//
//  TaskPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 2.04.22.
//

import Foundation

protocol TaskPresenterProtocol {
    func goToTaskList()
    func getTasks() -> [TaskModel]
    func setTasks(tasks: [TaskModel])
    func addTask(task: TaskModel)
    func updateTask(task: TaskModel, taskIndex: Int)
}

class TaskPresenter: TaskPresenterProtocol {
    
    weak var vc: TaskViewController?
    private let router: TaskRouter
    private var tasks: [TaskModel] = []
    
    init(router: TaskRouter) {
        self.router = router
    }
    
    func goToTaskList() {
        guard let vc = vc else {
            return
        }

        router.perform(to: .goToTaskList, viewController: vc)
    }
    
    func getTasks() -> [TaskModel] {
        return self.tasks
    }
    
    func setTasks(tasks: [TaskModel]) {
        self.tasks = tasks
    }
    
    func addTask(task: TaskModel) {
        tasks.append(task)
    }
    
    func updateTask(task: TaskModel, taskIndex: Int) {
        tasks[taskIndex] = task
        vc?.updateTaskTable()
    }
    
}
