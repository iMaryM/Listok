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
            let authService = FireBaseAuthManager.shared
            let router = ProfileRouter()
            let firstVC = TaskViewController()
            let secondVC = ProfileViewController(authService: authService, router: router)
            let vc = ContainerFactory().create(firstViewController: firstVC, secondViewController: secondVC)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
