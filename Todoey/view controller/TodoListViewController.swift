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
    
    ///user default for default database
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init data source from user default db
        if let items = userDefault.array(forKey: "todoListArray") as? [Item]
        {
            itemArray = items
        }
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
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //add item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item To the List", message: "", preferredStyle: .alert)
        let newItem = Item(title: "", done: false)
        alert.addTextField { (newTextField) in
            newTextField.placeholder = "create new item"
            newItem.m_title =  newTextField.text!
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when button pressed
            self.itemArray.append(newItem)
            self.userDefault.set(self.itemArray, forKey: "todoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
}

