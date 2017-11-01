//
//  TodosTableViewViewModel.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit
import RealmSwift

class TodosTableViewViewModel: NSObject {
    // Current Todo list
    var todoArray : [TodoCellViewModel] = []
    
    // Realm Instance
    var realm : Realm! = try! Realm()
    
    // Get Todo list from Realm
    func getTodos(_ keyword : String ,completion:@escaping() -> Void){
        
        todoArray = []
        let todos = self.realm.objects(TodoModel.self)
        
        for todoItem in todos {
            if keyword.characters.count > 0 {
                let stringTitle = todoItem.title.lowercased() as NSString
                if stringTitle.range(of: keyword.lowercased()).location != NSNotFound {
                    todoArray.append(todoItem as TodoCellViewModel)
                }
            } else {
                todoArray.append(todoItem as TodoCellViewModel)
            }
        }
        
        // sort data
        sortTodos(completion)       
        
    }
    
    // Sort todo array
    func sortTodos(_ completion : @escaping() -> Void){
        if AppSession.sharedInstance.sortType == .name {
            todoArray = todoArray.sorted(by: {
                $0.todoTitle < $1.todoTitle
            })
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            
            todoArray = todoArray.sorted(by: {
                dateFormatter.date(from: $0.todoDate)?.compare(dateFormatter.date(from: $1.todoDate)!) == .orderedAscending
            })
        }
        
        completion()
    }
    
    // Delete Todo item at index
    func deleteTodo(_ index : Int, completion : @escaping () -> Void){
        let todoId = self.todoArray[index].todoId
        if let obj = self.realm.objects(TodoModel.self).filter("id = %@", todoId).first {
            try! self.realm.write {
                self.realm.delete(obj)
            }
            
            self.todoArray.remove(at: index)
            completion()
        }
    }
    
    // Add new Todo item
    func addNewTodo(_ title : String, completion:@escaping() -> Void){
        
        // Get current date
        let stringDate = self.getCurrentDateString()
        
        //add Todo item to Realm
        let newTodo = TodoModel()
        newTodo.id = stringDate
        newTodo.title = title
        newTodo.date = stringDate
        
        try! self.realm.write {
            self.realm.add(newTodo)
        }
        
        self.todoArray.append(newTodo as TodoCellViewModel)
        
        completion()
    }
    
    // update Todo item
    func updateTodo(_ todoItem : TodoCellViewModel, updatedTitle : String){
        let currrentDateString = self.getCurrentDateString()        
        
        try! self.realm.write {
            todoItem.setDate(currrentDateString)
            todoItem.setTitle(updatedTitle)
        }
    }
    
    
    // Get current date string
    func getCurrentDateString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
