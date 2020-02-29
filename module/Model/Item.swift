//
//  Item.swift
//  Todo
//
//  Created by The Remedy on 28/02/2020.
//  Copyright © 2020 The Remedy. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "toItems")
    
}
