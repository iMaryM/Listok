//
//  SplashRouter.swift
//  Listok
//
//  Created by Мария Манжос on 11.02.22.
//

import Foundation
import UIKit

enum SplashSegue {
    case goToSignUp
    case goToLogin
}

protocol SplashRouterProtocol {
    func perform(to segue: SplashSegue, viewController: UIViewController)
}

class SplashRouter: SplashRouterProtocol {

    func perform(to segue: SplashSegue, viewController: UIViewController) {
        switch segue {
        case .goToSignUp:
            let vc = AuthFactory().create(by: .signUp)
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .goToLogin:
            let vc = AuthFactory().create(by: .login)
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
