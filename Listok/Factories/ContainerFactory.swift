//
//  ContainerFactory.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import Foundation
import UIKit

protocol ContainerFactoryProtocol {
    func createContainer(firstViewController: TaskViewControllerDelegate, secondViewController: UIViewController) -> ContainerViewController
}

class ContainerFactory: ContainerFactoryProtocol {
    func createContainer(firstViewController: TaskViewControllerDelegate, secondViewController: UIViewController) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.setViewController(firstViewController: firstViewController, secondViewController: secondViewController)
        return viewController
    }
}

protocol TaskFactoryProtocol {
    func createViewController() -> UIViewController
    func createTaskViewController() -> TaskViewControllerDelegate
}

class TaskFactory: TaskFactoryProtocol {
    func createViewController() -> UIViewController {

            return  getProfilleController()
    }
    
    func createTaskViewController() -> TaskViewControllerDelegate {
        return getTaskViewController()
    }
}

private extension TaskFactory {
    func getTaskViewController() -> TaskViewController {
        
        let vc = TaskViewController()
        let presenter = TaskPresenter(vc: vc)
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

