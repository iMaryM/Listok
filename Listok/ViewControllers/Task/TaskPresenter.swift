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
    func getAttributedStringFromCurrentDate() -> NSMutableAttributedString
}

class TaskPresenter: TaskPresenterProtocol {
    
    private weak var vc: TaskViewControllerProtocol?
    private var tasks: [TaskModel] = [
        TaskModel(title: "wrwerwer", time: "12:12:12"),
        TaskModel(title: "wqw   q", time: "12:12:12"),
        TaskModel(title: "qe     q  e q ", time: "12:12:12"),
        TaskModel(title: "123  123 eqw qw", time: "12:12:12"),
        TaskModel(title: "qwe", time: "12:12:12")
    ]
    private var calendarCell = CalendarCellModel()
    
    required init(vc: TaskViewControllerProtocol) {
        self.vc = vc
    }
    
    func getTasks() -> [TaskModel] {
        return tasks
    }
    
    func getDates() -> [DateModel] {
        return calendarCell.getDates()
    }
    
    func getAttributedStringFromCurrentDate() -> NSMutableAttributedString {
        return calendarCell.createDateLabelText()
    }
    
}
