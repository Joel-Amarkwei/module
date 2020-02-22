//
//  ViewController.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = [Modle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Modle()
        newItem1.title = "Rude Bouy"
        itemArray.append(newItem1)
        
        
        let newItem2 = Modle()
        newItem2.title = "Stone Bwouy"
        itemArray.append(newItem2)
        
        
        let newItem3 = Modle()
        newItem3.title = "Clark Kent"
        itemArray.append(newItem3)
//
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
    }
    
//MARK: - Adding a new barbutton
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new ToDo", message: "", preferredStyle: .alert)
        
        
           let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            var newItem = Modle()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
           }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a Todo"
            textField = alertTextField
        }
        
           alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
    }
    
   
}

