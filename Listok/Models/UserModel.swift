//
//  UserModel.swift
//  Listok
//
//  Created by Мария Манжос on 4.02.22.
//

import Foundation

class UserModel {
    
    var username: String
    var email: String
    var password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
}
