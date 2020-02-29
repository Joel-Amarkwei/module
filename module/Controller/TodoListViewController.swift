//
//  ViewController.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

// print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    var itemArray : Results<Item>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
  }

    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = itemArray?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = (item.done) ? .checkmark : .none
        } else{
            
             cell.textLabel?.text = "No items added yet"
        }
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
                   // realm.delete(item)
                }
            } catch{
                print("Error saving done status \(error)")
            }
        }
           tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK: - Adding a new barbutton
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        
        
           let action = UIAlertAction(title: "Add items", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory{
                
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.toItems.append(newItem) //check this line very well it is very key
                        newItem.dateCreated = Date()
                        print("date created = \(newItem.dateCreated)")
                    }
                } catch{
                    print("error trying to create new item \(error)")
                }
                  }
          
            self.tableView.reloadData()

           }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a Todo"
            textField = alertTextField
        }
        
           alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Saving Data Into the Database --Saving
    
    func saveItems(item: Item){
        
        do{
            try realm.write{
                realm.add(item)
            }
        } catch{
            print("errors not handled \(Error.self)")
            }
            
        tableView.reloadData()
        
    }
    
    //MARK: - Loading Data from Database --Reading
    
    func loadItems(){

        itemArray = selectedCategory?.toItems.sorted(byKeyPath: "title", ascending: true)
        
         self.tableView.reloadData()
}

}

// MARK: - EXTENTIONS USING A SEARCHBAR

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
    }
 
    //After search formalities
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text?.count == 0 {
            loadItems()

        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }

      }
    }

}
    
