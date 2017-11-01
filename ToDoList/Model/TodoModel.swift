//
//  TodoModel.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit
import RealmSwift

class TodoModel: Object {
    // id 
    @objc dynamic var id: String!
    
    // title
    @objc dynamic var title: String!
    
    // created date
    @objc dynamic var date: String!
}
