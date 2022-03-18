//
//  SignUpModel.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import Foundation

protocol SignUpModelProtocol {
    func createUser(email: String, password: String, closure: @escaping  (Result<Void, Error>) -> Void)
}

class SignUpModel: SignUpModelProtocol {

    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func createUser(email: String, password: String, closure: @escaping  (Result<Void, Error>) -> Void) {
        
        authService.createUser(email: email, password: password) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.authService.signIn(email: email, password: password) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    switch result {
                    case .success:
                        self.saveUserDefaults(email: email, password: password)
                        closure(.success(()))
                    case .failure(let error):
                        closure(.failure(error))
                        
                    }
                }
            case .failure(let error):
                closure(.failure(error))
            }
        }
        
    }
    
    private func checkSavedCredential() -> Bool {
        return ((UserDefaults.standard.value(forKey: KeyesUserDefaults.email.rawValue) != nil) || (UserDefaults.standard.value(forKey: KeyesUserDefaults.password.rawValue) != nil))
    }
    
    private func clearUserDefaults(email: String, password: String) {
        UserDefaults.standard.removeObject(forKey: email)
        UserDefaults.standard.removeObject(forKey: password)
    }
    
    private func saveUserDefaults(email: String, password: String) {
        
        if (checkSavedCredential()) {
            clearUserDefaults(email: email, password: password)
        }
        
        UserDefaults.standard.setValue(email, forKey: KeyesUserDefaults.email.rawValue)
        UserDefaults.standard.setValue(password, forKey: KeyesUserDefaults.password.rawValue)
    }
    
}
