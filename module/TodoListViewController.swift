//
//  ViewController.swift
//  module
//
//  Created by The Remedy on 19/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Mandacolos", "Shemacolos", "Fletcherolos"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

}

