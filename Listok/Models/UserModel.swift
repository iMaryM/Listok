//
//  UserModel.swift
//  Listok
//
//  Created by Мария Манжос on 4.02.22.
//

import Foundation

class UserModel {
    
    var username: String?
    var email: String
    
    init(username: String? = nil, email: String) {
        self.username = username
        self.email = email
    }
    
}
