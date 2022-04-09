//
//  TaskRouter.swift
//  Listok
//
//  Created by Мария Манжос on 2.04.22.
//

import Foundation
import UIKit

enum TaskSegue {
    case goToTaskList
    case showAddAlert
}

protocol TaskRouterProtocol {
    func perform(to segue: TaskSegue, viewController: TaskViewController)
}

class TaskRouter: TaskRouterProtocol {

    func perform(to segue: TaskSegue, viewController: TaskViewController) {
        switch segue {
        case .goToTaskList:
            viewController.navigationController?.popViewController(animated: true)
        case .showAddAlert:
            print("showAddAlert")
        }
        
    }
}
