//
//  ItemModel.swift
//  APP-TodoeyList
//
//  Created by José Eduardo Rodríguez Reyes on 28/07/21.
//

import Foundation

class ItemModel {
    var toDoTitle: String
    var done: Bool
    
    init() { // empty constructor
        self.toDoTitle = ""
        self.done = false
    }
    /*
    init(toDoTitle: String, done: Bool) {
        self.toDoTitle = toDoTitle
        self.done = done
    }*/
}
