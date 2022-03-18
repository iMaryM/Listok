//
//  SignUpRouter.swift
//  Listok
//
//  Created by Мария Манжос on 15.02.22.
//

import Foundation
import UIKit

enum SignUpSegue {
    case goToTask
    case goToLogin
    case showErrorAlert(error: Error)
}

protocol SignUpRouterProtocol {
    func perform(to segue: SignUpSegue, viewController: UIViewController)
}

class SignUpRouter: SignUpRouterProtocol {

    func perform(to segue: SignUpSegue, viewController: UIViewController) {
        switch segue {
        case .goToLogin:
            let vc = AuthFactory().create(by: .login)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .goToTask:
            let controllerFactory = TaskFactory()
            let firstVC = controllerFactory.createTaskViewController()
            let secondVC = controllerFactory.createViewController()
            let vc = ContainerFactory().createContainer(firstViewController: firstVC, secondViewController: secondVC)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .showErrorAlert(let error):
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
}
