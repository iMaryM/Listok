//
//  ContainerFactory.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import Foundation
import UIKit

protocol ContainerFactoryProtocol {
    func createContainer(firstViewController: UIViewController, secondViewController: UIViewController) -> ContainerViewController
}

class ContainerFactory: ContainerFactoryProtocol {
    func createContainer(firstViewController: UIViewController, secondViewController: UIViewController) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.setViewController(firstViewController: firstViewController, secondViewController: secondViewController)
        return viewController
    }
}

enum IDViewControllers {
    case task
    case profile
}

protocol TaskFactoryProtocol {
    func create(_ id: IDViewControllers) -> UIViewController
}

class TaskFactory: TaskFactoryProtocol {
    func create(_ id: IDViewControllers) -> UIViewController {
        switch id {
        case .task:
            return getTaskViewController()
        case .profile:
            return  getProfilleController()
        }
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

