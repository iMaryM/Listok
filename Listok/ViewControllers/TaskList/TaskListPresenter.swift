//
//  TaskListPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 18.02.22.
//

import Foundation

protocol TaskListPresenterProtocol {
    init(vc: TaskListViewControllerProtocol)
    func getTaskLists() -> [TaskListModel]
    func getTasks(from taskList: TaskListModel) -> [TaskModel]
    func getDates() -> [DateModel]
    func setTasks(indexTaskList: Int, tasks: [TaskModel])
    func addTaskLists(taskList: TaskListModel)
    func deleteTaskList(taskListIndex: Int)
}

class TaskListPresenter: TaskListPresenterProtocol {
    
    private weak var vc: TaskListViewControllerProtocol?
    private var taskLists: [TaskListModel] = []
    private var calendarDates = [DateModel]()

    required init(vc: TaskListViewControllerProtocol) {
        self.vc = vc
    }
    
    func getTaskLists() -> [TaskListModel] {
        return taskLists
    }
    
    func getTasks(from taskList: TaskListModel) -> [TaskModel] {
        return taskList.tasks
    }
    
    func getDates() -> [DateModel] {
        return calendarDates.generateDates()
    }
    
    func setTasks(indexTaskList: Int, tasks: [TaskModel]) {
        self.taskLists[indexTaskList].tasks = tasks
    }
    
    func addTaskLists(taskList: TaskListModel) {
        taskLists.append(taskList)
        vc?.updateTaskTable()
    }
    
    func deleteTaskList(taskListIndex: Int) {
        taskLists.remove(at: taskListIndex)
        vc?.updateTaskTable()
    }
    
}



