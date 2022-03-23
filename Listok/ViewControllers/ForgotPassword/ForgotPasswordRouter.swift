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
    case showSuccessAlert
    case showErrorAlert(error: Error)
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
        case .showSuccessAlert:
            let alert = UIAlertController(title: "Success", message: "Reset password email has been successfully sent", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { action in
                viewController.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        case .showErrorAlert(let error):
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
