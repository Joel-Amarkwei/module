//
//  CategoryViewController.swift
//  module
//
//  Created by The Remedy on 25/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var categoryArray = [Category]()


    override func viewDidLoad() {
        super.viewDidLoad()

        loadTodo()
    }
    
    //MARK: - TableView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
     //   tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new todo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add Item", style: .default) { (action) in
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            
            self.categoryArray.append(newItem)
                self.saveTodo()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Todo"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
    }
    
    func saveTodo(){
        do{
            try context.save()
        } catch{
            print("Error saving items to database \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadTodo(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArray = try context.fetch(request)
        } catch{
            print("Error loading data from database \(error)")
        }
         self.tableView.reloadData()
    }
   
}
