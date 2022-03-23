//
//  UserDefaultManager.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let userDefauts = UserDefaults.standard
    
    private init() { }
    
    func checkSavedParam(forKey key: String) -> Bool {
        return ((userDefauts.value(forKey: key) != nil))
    }
    
    func clearParam(forKey key: String) {
        userDefauts.removeObject(forKey: key)
    }
    
    func saveParams(params: [String: String]) {
        params.forEach { param in
            userDefauts.setValue(param.value, forKey: param.key)
        }
    }
    
    func getParam(forKey key: String) -> String? {
        return userDefauts.string(forKey: key)
    }
    
    
}
