//
//  ForgotPasswordModel.swift
//  Listok
//
//  Created by Мария Манжос on 23.03.22.
//

import Foundation
import UIKit

protocol ForgotPasswordModelProtocol {
    func sendPassword(email: String, closure: @escaping (Result<Void,Error>) -> ())
    func getCredentials() -> String?
}

class ForgotPasswordModel: ForgotPasswordModelProtocol {
    
    private let authService: AuthServiceProtocol

    
    private let userDefaultsManager = UserDefaultManager.shared
    
    private var emailText: String?
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func sendPassword(email: String, closure: @escaping (Result<Void,Error>) -> ()) {
        authService.sendPasswordReset(withEmail: email) { result in
            switch result {
            case .success:
                closure(.success(()))
            case .failure(let error):
                closure(.failure(error))
            }
        }
    }
    
    func getCredentials() -> String? {
        return userDefaultsManager.getParam(forKey: KeyesUserDefaults.email.rawValue)
    }
    
}
