//
//  ForgotPasswordPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 23.03.22.
//

import Foundation
import UIKit

protocol ForgotPasswordPresenterProtocol {
    func goToLoginViewCOntroller(_ vc: UIViewController)
    func sendPassword(email: String)
    func getCredentials() -> String?
}

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    
    private var model: ForgotPasswordModelProtocol
    private let router: ForgotPasswordRouterProtocol
    weak var vc: UIViewController?
    
    init(model: ForgotPasswordModelProtocol, router: ForgotPasswordRouterProtocol) {
        self.model = model
        self.router = router
    }
    
    func goToLoginViewCOntroller(_ vc: UIViewController) {
        router.perform(segue: .goToLogin, viewController: vc)
    }
    
    func sendPassword(email: String) {
        guard let vc = vc else { return }
        model.sendPassword(email: email) { result in
            switch result {
            case .success(()):
                self.router.perform(segue: .showSuccessAlert, viewController: vc)
            case .failure(let error):
                self.router.perform(segue: .showErrorAlert(error: error), viewController: vc)
            }
        }
    }
    
    func getCredentials() -> String? {
        model.getCredentials()
    }

}
