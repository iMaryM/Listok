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
            let authService = FireBaseAuthManager.shared
            let router = ProfileRouter()
            let firstVC = TaskViewController()
            let secondVC = ProfileViewController(authService: authService, router: router)
            let vc = ContainerFactory().create(firstViewController: firstVC, secondViewController: secondVC)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .forgotPassword:
            let vc = AuthFactory().create(by: .forgotPassword)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}