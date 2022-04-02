//
//  AuthFactory.swift
//  Listok
//
//  Created by Мария Манжос on 11.02.22.
//

import Foundation
import UIKit

enum IdViewController {
    case login
    case signUp
    case forgotPassword
}

class AuthFactory {
    func create(by id: IdViewController) -> UIViewController {
        switch id {
        case .login:
            return getLoginViewController()
        case .signUp:
            return getSignUpViewController()
        case .forgotPassword:
            return getForgotPasswordViewController()
        }
    }
}

private extension AuthFactory {
    func getLoginViewController() -> UIViewController {
        let service = FireBaseAuthManager.shared
        let router = LoginRouter()
        let model = LoginModel(authService: service)
        let presenter = LoginPresenter(model: model, router: router)
        let vc = LoginViewController()
        presenter.vc = vc
        vc.setPresenter(presenter: presenter)
        return vc
    }
    
    func getSignUpViewController() -> UIViewController {
        let service = FireBaseAuthManager.shared
        let router = SignUpRouter()
        let vc = SignUpViewController()
        let model = SignUpModel(authService: service)
        let presenter = SignUpPresenter(model: model, router: router)
        presenter.vc = vc
        vc.setPresenter(presenter: presenter)
        return vc
    }
    
    func getForgotPasswordViewController() -> UIViewController {
        let service = FireBaseAuthManager.shared
        let router = ForgotPasswordRouter()
        let forgotPasswordModel = ForgotPasswordModel(authService: service)
        let presenter = ForgotPasswordPresenter(model: forgotPasswordModel, router: router)
        let vc = ForgotPasswordViewController()
        presenter.vc = vc
        vc.setPresenter(presenter: presenter)
        return vc
    }
}
