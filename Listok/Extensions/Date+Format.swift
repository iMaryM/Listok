//
//  Date+Format.swift
//  Listok
//
//  Created by Мария Манжос on 15.02.22.
//

import Foundation
import UIKit

extension Date {
    func getFormettedDateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getAttributedStringDate() -> NSMutableAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMMM"
        var string = dateFormatter.string(from: self)
        dateFormatter.dateFormat = "yyyy"
        string += "\n"
        string += dateFormatter.string(from: self)
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor : UIColor(red: 82 / 255, green: 95 / 254, blue: 119 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        return attributedString
    }
    
}
