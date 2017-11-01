//
//  AppSession.swift
//  ToDoList
//
//  Created by Panda on 10/31/17.
//  Copyright © 2017 Panda. All rights reserved.
//

import UIKit

class AppSession: NSObject {
    
    static var sharedInstance : AppSession = {
        var instance = AppSession()
        return instance
    }()

    var sortType : SortType = .name
}
