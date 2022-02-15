//
//  Date+Format.swift
//  Listok
//
//  Created by Мария Манжос on 15.02.22.
//

import Foundation

extension Date {
    func getFormettedDateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
