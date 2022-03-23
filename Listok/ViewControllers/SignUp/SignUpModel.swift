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

    private let userDefaultsManager = UserDefaultManager.shared
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
                        self.userDefaultsManager.saveParams(params: [KeyesUserDefaults.email.rawValue : email, KeyesUserDefaults.password.rawValue : password])
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
    
}
