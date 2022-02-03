//
//  FireBaseAuthManager.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import FirebaseAuth

class FireBaseAuthManager {
    public static let shared = FireBaseAuthManager()
    
    func authentication (with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("error = \(error.localizedDescription)")
            } else {
                if let result = authResult {
                    print("UserID = \(result.user.uid)")
                }
            }
        }
    }
}
