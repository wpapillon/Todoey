//
//  ViewController.swift
//  Todoey
//
//  Created by Yexiao Wu on 2019-02-12.
//  Copyright © 2019 Yexiao Wu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //data source
    var itemArray = [Item]()
    //data persis by creating our own plist instead of using the user default
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoListItem.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.m_title
        cell.accessoryType = item.m_done ? .checkmark : .none
        return cell
    }
   
    //table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].m_done = !itemArray[indexPath.row].m_done
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //add item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item To the List", message: "", preferredStyle: .alert)
        
        
        var textField = UITextField()
        
        alert.addTextField { (newTextField) in
            newTextField.placeholder = "create new item"
            textField = newTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //what will happen when button pressed
            let newItem = Item(title: textField.text!, done: false)
            self.itemArray.append(newItem)
           
            self.saveItems()
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)");
        }
        
    }
    func loadItems() {
       if let data = try? Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
        do{
            itemArray = try decoder.decode([Item].self, from: data)
        }catch{
            print("error decoding, \(error)")
        }
        }
    }
    
}

