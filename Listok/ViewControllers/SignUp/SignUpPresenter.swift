//
//  SignUpPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 15.03.22.
//

import Foundation
import UIKit

protocol SignUpPresenterProtocol {
    func goToLoginViewCOntroller()
    func createProfile(email: String, password: String)
}

class SignUpPresenter: SignUpPresenterProtocol {

    private let model: SignUpModelProtocol
    private let router: SignUpRouterProtocol
    weak var vc: UIViewController?
    
    init(model: SignUpModelProtocol, router: SignUpRouterProtocol) {
        self.model = model
        self.router = router
    }
    
    func goToLoginViewCOntroller() {
        guard let vc = vc else { return }
        router.perform(to: .goToLogin, viewController: vc)
    }
    
    func createProfile(email: String, password: String) {
        model.createUser(email: email, password: password) { [weak self] result in
            
            guard let self = self,
            let vc = self.vc else {return}
            
            switch result {
            case .success:
                self.router.perform(to: .goToTask, viewController: vc)
            case .failure(let error):
                self.router.perform(to: .showErrorAlert(error: error), viewController: vc)
            }
        }
    }
    

    
}
