//
//  TodoCellViewModel.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

protocol TodoCellViewModel {
    var todoTitle : String {get}
    var todoDate : String {get}
    var todoId : String {get}
    
    func setTitle(_ title : String)
    func setDate(_ date : String)
}

extension TodoModel : TodoCellViewModel {
    var todoTitle : String{
        return title
    }
    
    var todoDate : String{
        return date
    }
    
    var todoId: String{
        return id
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setDate(_ date: String) {
        self.date = date
    }
}
