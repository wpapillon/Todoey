//
//  ViewController.swift
//  Todoey
//
//  Created by Yexiao Wu on 2019-02-12.
//  Copyright © 2019 Yexiao Wu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["work","drive","gas"]
    ///user default for default database
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = userDefault.array(forKey: "todoListArray") as? [String]
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
   
    //table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //add item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item To the List", message: "", preferredStyle: .alert)
        var newItem = UITextField()
        alert.addTextField { (newTextField) in
            newTextField.placeholder = "create new item"
            newItem =  newTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when button pressed
            self.itemArray.append(newItem.text!)
            self.userDefault.set(self.itemArray, forKey: "todoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
}

