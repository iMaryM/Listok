//
//  FormattedString.swift
//  Listok
//
//  Created by Мария Манжос on 14.02.22.
//

import Foundation
import UIKit

enum FormattedString {
    case largeText(isSelected: Bool)
    case mediumText(isSelected: Bool)
}

extension FormattedString {
    var font: UIFont {
        switch self {
        case .largeText:
            return UIFont(name: "Roboto-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
        case .mediumText:
            return UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .largeText(let isSelected):
            return isSelected ? UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1) : UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        case .mediumText(let isSelected):
            return isSelected ?  UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.4) : UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        }
    }
}
