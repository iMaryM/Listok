//
//  SignUpModel.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import Foundation

protocol SignUpModelProtocol {
    func createUser(user: UserModel, closure: @escaping  (Result<Void, Error>) -> Void) 
}

class SignUpModel: SignUpModelProtocol {

    private let userDefaultsManager = UserDefaultManager.shared
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func createUser(user: UserModel, closure: @escaping  (Result<Void, Error>) -> Void) {
        
        authService.createUser(email: user.email, password: user.password) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.authService.signIn(email: user.email, password: user.password) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    switch result {
                    case .success:
                        self.userDefaultsManager.saveParams(params: [KeyesUserDefaults.username.rawValue : user.username, KeyesUserDefaults.email.rawValue : user.email, KeyesUserDefaults.password.rawValue : user.password])
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
