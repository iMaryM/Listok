//
//  ForgotPasswordModel.swift
//  Listok
//
//  Created by Мария Манжос on 23.03.22.
//

import Foundation
import UIKit

class ForgotPasswordModel {
    
    private let authService: AuthServiceProtocol
    private let router: ForgotPasswordRouterProtocol
    
    private let userDefaultsManager = UserDefaultManager.shared
    
    private var emailText: String?
    
    init(authService: AuthServiceProtocol, router: ForgotPasswordRouterProtocol) {
        self.authService = authService
        self.router = router
    }
    
    func goToLoginViewCOntroller(_ vc: UIViewController) {
        router.perform(segue: .goToLogin, viewController: vc)
    }
    
    func sendPassword(email: String, vc: UIViewController) {
        authService.sendPasswordReset(withEmail: email) { result in
            switch result {
            case .success:
                self.router.perform(segue: .showSuccessAlert, viewController: vc)
            case .failure(let error):
                self.router.perform(segue: .showErrorAlert(error: error), viewController: vc)
            }
        }
    }
    
    func getCredentials() -> String? {
    
        return userDefaultsManager.getParam(forKey: KeyesUserDefaults.email.rawValue)

    }
    
}
