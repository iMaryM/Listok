//
//  LoginPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import Foundation


class LoginPresenter {
    
    weak var vc: LoginViewController?
    private let model: LoginModelProtocol
    private let router: LoginRouterProtocol
    
    init(model: LoginModelProtocol, router: LoginRouterProtocol) {
        self.model = model
        self.router = router
    }
    
    func goToForgotPasswordViewCOntroller() {
        guard let vc = vc else {return }
        router.perform(to: .forgotPassword, viewController: vc)
    }
    
    func goToSignUpViewCOntroller() {
        guard let vc = vc else {return }
        router.perform(to: .goToSignUp, viewController: vc)
    }
    
    func goToTaskViewController(email: String, password: String) {
    
        model.goToTaskViewController(email: email, password: password) { [weak self] result in
            
            guard let self = self,
                  let vc = self.vc else { return }
            
            switch result {
            case .success:
                self.router.perform(to: .goToTask, viewController: vc)
            case .failure(let error):
                self.router.perform(to: .showErorrAlert(error: error), viewController: vc)
            }
        }
    }
    
    func getCredentials() -> UserModel {
        return model.getCredentials()
    }
    
}
