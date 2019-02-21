//
//  CategaryTableViewController.swift
//  Todoey
//
//  Created by Yexiao Wu on 2019-02-19.
//  Copyright © 2019 Yexiao Wu. All rights reserved.
//

import UIKit
import CoreData

class CategaryTableViewController: UITableViewController {

    //data source
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }


    
    
    //MARK: TableView Data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.title
        return cell
    }
    //MARK: TABLE VIEW DALEGATE Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoitems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //MARK: DATA MANIPULATION
        let alert = UIAlertController(title: "Add Category To the List", message: "", preferredStyle: .alert)
        var textField = UITextField()
    alert.addTextField { (newTextField) in
    newTextField.placeholder = "create new category"
    textField = newTextField
    }
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
        //what will happen when button pressed
        
        let newItem = Category(context: self.context)
        
        newItem.title = textField.text!
        self.categories.append(newItem)
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
func loadItems(with request:NSFetchRequest<Category>  = Category.fetchRequest()) {
    do{
        try categories = context.fetch(request)
    }catch{
        print("Error fetching context, \(error)");}
    tableView.reloadData()
}

    
}
