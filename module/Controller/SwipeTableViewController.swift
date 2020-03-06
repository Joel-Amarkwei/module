//
//  SwipeTableViewController.swift
//  Todo
//
//  Created by The Remedy on 04/03/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  SwipeTableViewCell
        
                cell.delegate = self
                
                return cell
    }

   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
          guard orientation == .right else { return nil }

          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              
            self.updateModel(at: indexPath)
            
                }

              print("item deleted")

          // customize the action appearance
          deleteAction.image = UIImage(named: "trash")
          

          return [deleteAction]
      }
      
      func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
          var options = SwipeOptions()
          options.expansionStyle = .destructive
          options.transitionStyle = .border
          return options
      }
    
    func updateModel(at indexPath: IndexPath){
        
    }
}
