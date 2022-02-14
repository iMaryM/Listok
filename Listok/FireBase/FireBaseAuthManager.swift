//
//  FireBaseAuthManager.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func createUser(email: String, password: String, closure: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signIn(email: String, password: String, closure: @escaping (Result<Void, Error>) -> Void)
    func logOut(closure: () -> ())
    func sendPasswordReset(withEmail email: String, closure: @escaping (Result<Void, Error>) -> ())
}

class FireBaseAuthManager: AuthServiceProtocol {
    public static let shared = FireBaseAuthManager()
    
    private init() {}

    func createUser(email: String, password: String, closure: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                closure(.failure(error))
            } else {
                if let result = authResult {
                    closure(.success(result))
                }
            }
        }
    }
    
    func signIn(email: String, password: String, closure: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                closure(.failure(error))
            } else {
                if let _ = authResult {
                    closure(.success(()))
                }
            }
        }
    }
    
    func logOut(closure: () -> ()) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            closure()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func sendPasswordReset(withEmail email: String, closure: @escaping (Result<Void, Error>) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                closure(.failure(error))
            } else {
                closure(.success(()))
            }
        }
    }
}
