//
//  CategoryViewController.swift
//  module
//
//  Created by The Remedy on 25/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {

//     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
        loadTodo()
    }
    
    //MARK: - TableView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
     cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new todo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            
            let newItem = Category()
            newItem.name = textField.text!
            
            self.saveTodo(category: newItem)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Todo"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    func saveTodo(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        } catch{
            print("Error saving items to database \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadTodo(){
        
        categoryArray = realm.objects(Category.self)
        
        self.tableView.reloadData()
    }
    
    //Deleting function here
    override func updateModel(at indexPath: IndexPath) {
        if let cellForDeletion = self.categoryArray?[indexPath.row]{
        do{
            try self.realm.write{
            self.realm.delete(cellForDeletion)
                        }
                } catch{
                        print("Error deleting items to database \(error)")
                        }
    }
   
}
}
