//
//  LoginModel.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import Foundation

class LoginModel {
    private let authService: AuthServiceProtocol
    private let userDefaultsManager = UserDefaultManager.shared
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func goToTaskViewController(email: String, password: String, closure: @escaping (Result<Void, Error>) -> Void) {
    
        authService.signIn(email: email, password: password) { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success():
                closure(.success(()))
                self.userDefaultsManager.saveParams(params: [KeyesUserDefaults.email.rawValue : email, KeyesUserDefaults.password.rawValue : password])
            case .failure(let error):
                closure(.failure(error))
            }
        }
    }
    
    func getCredentials() -> UserModel {
        
        var username = ""
        var email = ""
        var password = ""
        
        if userDefaultsManager.checkSavedParam(forKey: KeyesUserDefaults.username.rawValue) {
            username = userDefaultsManager.getParam(forKey: KeyesUserDefaults.username.rawValue)!
        }
        
        if userDefaultsManager.checkSavedParam(forKey: KeyesUserDefaults.email.rawValue) {
            email = userDefaultsManager.getParam(forKey: KeyesUserDefaults.email.rawValue)!
        }
        
        if userDefaultsManager.checkSavedParam(forKey: KeyesUserDefaults.password.rawValue) {
            password = userDefaultsManager.getParam(forKey: KeyesUserDefaults.password.rawValue)!
        }
            
        return UserModel(username: username, email: email, password: password)
    }
    
}
