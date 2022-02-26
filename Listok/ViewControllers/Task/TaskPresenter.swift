//
//  TaskPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 18.02.22.
//

import Foundation

protocol TaskPresenterProtocol {
    init(vc: TaskViewControllerProtocol)
    func getTasks() -> [TaskModel]
    func getDates() -> [DateModel]
    func addTask(task: TaskModel)
}

class TaskPresenter: TaskPresenterProtocol {
    
    private weak var vc: TaskViewControllerProtocol?
    private var tasks: [TaskModel] = []
    private var calendarDates = [DateModel]()

    
    required init(vc: TaskViewControllerProtocol) {
        self.vc = vc
    }
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func getDates() -> [DateModel] {
        return calendarDates.generateDates()
    }
    
    func addTask(task: TaskModel) {
        tasks.append(task)
        vc?.updateTaskTable()
    }
    
}



