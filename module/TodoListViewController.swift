//
//  ViewController.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
//       
//    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("New Itms")
//    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      // loadItems()
        
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
        
        self.saveItems()
        
        //self.loadItems()
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.reloadData()
        
    }
    
//MARK: - Adding a new barbutton
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new ToDo", message: "", preferredStyle: .alert)
        
        
           let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                        
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
           // self.loadItems()
            
           }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a Todo"
            textField = alertTextField
        }
        
           alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
          //  self.loadItems()
    }
    
    func saveItems(){
        
        do{
            try context.save()
                } catch{
                    print("Error printing out context \(error)")
        }
        self.tableView.reloadData()
    }
    
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataPath!){
//
//             let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("there was an error \(error)")
//            }
//        }
//    }
   
}

