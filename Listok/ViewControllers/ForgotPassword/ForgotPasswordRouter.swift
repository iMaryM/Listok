//
//  ForgotPasswordRouter.swift
//  Listok
//
//  Created by Мария Манжос on 16.02.22.
//

import Foundation
import UIKit

enum ForgotPasswordSegue {
    case goToLogin
}

protocol ForgotPasswordRouterProtocol {
    func perform(segue: ForgotPasswordSegue, viewController: UIViewController)
}

class ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    func perform(segue: ForgotPasswordSegue, viewController: UIViewController) {
        switch segue {
        case .goToLogin:
            let vc = AuthFactory().create(by: .login)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
