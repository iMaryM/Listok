//
//  ContainerFactory.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import Foundation
import UIKit

protocol ContainerFactoryProtocol {
    func createContainer(firstViewController: TaskListViewControllerDelegate, secondViewController: UIViewController) -> ContainerViewController
}

class ContainerFactory: ContainerFactoryProtocol {
    func createContainer(firstViewController: TaskListViewControllerDelegate, secondViewController: UIViewController) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.setViewController(firstViewController: firstViewController, secondViewController: secondViewController)
        return viewController
    }
}

protocol TaskListFactoryProtocol {
    func createViewController() -> UIViewController
    func createTaskListViewController() -> TaskListViewControllerDelegate
}

class TaskListFactory: TaskListFactoryProtocol {
    func createViewController() -> UIViewController {

            return  getProfilleController()
    }
    
    func createTaskListViewController() -> TaskListViewControllerDelegate {
        return getTaskListViewController()
    }
}

private extension TaskListFactory {
    func getTaskListViewController() -> TaskListViewController {
        
        let vc = TaskListViewController()
        let presenter = TaskListPresenter(vc: vc)
        vc.setPresenter(presenter)
        return vc
    }
    
    func getProfilleController() -> ProfileViewController {
        let authService = FireBaseAuthManager.shared
        let router = ProfileRouter()
        let vc = ProfileViewController(authService: authService, router: router)
        return vc
    }
}

