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
            let vc = ContainerViewController()
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .forgotPassword:
            let vc = ForgotPasswordViewController()
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
