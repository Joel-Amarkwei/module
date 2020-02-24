//
//  ViewController.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
  //  let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemsArray")
    
    var itemArray = [Modle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        let newItem1 = Modle()
        newItem1.title = "Rude Bouy"
      //  newItem1.done = true
        itemArray.append(newItem1)
        
        
        let newItem2 = Modle()
        newItem2.title = "Stone Bwouy"
      //  newItem2.done = true
        itemArray.append(newItem2)
        
        
        let newItem3 = Modle()
        newItem3.title = "Clark Kent"
        itemArray.append(newItem3)

//        if let items = defaults.array(forKey: "TodoListArray") as? [Modle] {
//            itemArray = items
//        }
        
        self.saveItems()
    }

    //MARK: - TableView DataSource Methods
    
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
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
        
    }
    
//MARK: - Adding a new barbutton
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new ToDo", message: "", preferredStyle: .alert)
        
        
           let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            var newItem = Modle()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            } catch{
                print("Error trying to encode plist \(error)")
            }
                        
            self.saveItems()
           }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a Todo"
            textField = alertTextField
        }
        
           alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error trying to encode plist \(error)")
        }
    }
    
   
}

