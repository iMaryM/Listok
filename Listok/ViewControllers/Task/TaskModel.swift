//
//  TaskModel.swift
//  Listok
//
//  Created by Мария Манжос on 2.04.22.
//

import Foundation

class TaskModel {
    let task: String
    let isDone: Bool
    
    init(task: String, isDone: Bool = false) {
        self.task = task
        self.isDone = isDone
    }
}
