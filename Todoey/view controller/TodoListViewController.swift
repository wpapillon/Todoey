//
//  ViewController.swift
//  Todoey
//
//  Created by Yexiao Wu on 2019-02-12.
//  Copyright © 2019 Yexiao Wu. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    //data source
    var itemArray = [Item]()
    //data persis by creating our own plist instead of using the user default
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
   
    //MARK: - table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - add item
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Item To the List", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        alert.addTextField { (newTextField) in
            newTextField.placeholder = "create new item"
            textField = newTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //what will happen when button pressed
            
            let newItem = Item(context: self.context)
            newItem.done = false
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            
            
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    func saveItems()
    {
        do{
            try context.save()
        }catch{
            print("Error saving context, \(error)");
        }
        tableView.reloadData()
        
    }
    func loadItems(with request:NSFetchRequest<Item>  = Item.fetchRequest()) {
                do{
                    try itemArray = context.fetch(request)
                }catch{
                    print("Error fetching context, \(error)");}
                tableView.reloadData()
        }
   
    
}

// MARK: - search bar extension
extension TodoListViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
      
        loadItems(with: request)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
