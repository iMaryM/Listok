//
//  TaskPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 18.02.22.
//

import Foundation

protocol TaskPresenterProtocol {
    init(vc: TaskViewControllerProtocol)
    func getTasks() -> [ListTaskModel]
    func getDates() -> [DateModel]
    func addTask(task: ListTaskModel)
    func deleteTask(taskIndex: Int)
}

class TaskPresenter: TaskPresenterProtocol {
    
    private weak var vc: TaskViewControllerProtocol?
    private var tasks: [ListTaskModel] = []
    private var calendarDates = [DateModel]()

    
    required init(vc: TaskViewControllerProtocol) {
        self.vc = vc
    }
    
    func getTasks() -> [ListTaskModel] {
        return tasks
    }
    
    func getDates() -> [DateModel] {
        return calendarDates.generateDates()
    }
    
    func addTask(task: ListTaskModel) {
        tasks.append(task)
        vc?.updateTaskTable()
    }
    
    func deleteTask(taskIndex: Int) {
        tasks.remove(at: taskIndex)
        vc?.updateTaskTable()
    }
    
}



