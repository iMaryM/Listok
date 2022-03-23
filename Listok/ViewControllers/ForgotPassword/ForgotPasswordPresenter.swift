//
//  ForgotPasswordPresenter.swift
//  Listok
//
//  Created by Мария Манжос on 23.03.22.
//

import Foundation
import UIKit

protocol ForgotPasswordPresenterProtocol {
    func goToLoginViewCOntroller()
    func sendPassword(email: String)
    func getCredentials() -> String?
}

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    
    private var model: ForgotPasswordModelProtocol
    weak var vc: UIViewController?
    
    init(model: ForgotPasswordModelProtocol) {
        self.model = model
    }
    
    func goToLoginViewCOntroller() {
        guard let vc = vc else { return }
        model.goToLoginViewCOntroller(vc)
    }
    
    func sendPassword(email: String) {
        guard let vc = vc else { return }
        model.sendPassword(email: email, vc: vc)
    }
    
    func getCredentials() -> String? {
        model.getCredentials()
    }

}
