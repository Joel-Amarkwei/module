//
//  Category.swift
//  Todo
//
//  Created by The Remedy on 28/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    var toItems = List<Item>()
}
