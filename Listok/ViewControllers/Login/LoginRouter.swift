//
//  LoginRouter.swift
//  Listok
//
//  Created by Мария Манжос on 11.02.22.
//

import Foundation
import UIKit

enum LoginSegue {
    case goToSignUp
    case goToTask
    case forgotPassword
    case showErorrAlert(error: Error)
}

protocol LoginRouterProtocol {
    func perform(to segue: LoginSegue, viewController: UIViewController)
}

class LoginRouter: LoginRouterProtocol {

    func perform(to segue: LoginSegue, viewController: UIViewController) {
        switch segue {
        case .goToSignUp:
            let vc = AuthFactory().create(by: .signUp)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .goToTask:
            let controllerFactory = TaskListFactory()
            let firstVC = controllerFactory.createTaskListViewController()
            let secondVC = controllerFactory.createViewController()
            let vc = ContainerFactory().createContainer(firstViewController: firstVC, secondViewController: secondVC)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .forgotPassword:
            let vc = AuthFactory().create(by: .forgotPassword)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .showErorrAlert(let error):
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
