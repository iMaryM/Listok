//
//  TaskModel.swift
//  Listok
//
//  Created by Мария Манжос on 11.02.22.
//

import Foundation
import UIKit

class TaskModel {
    private let calendar = Calendar.current
    private var date = Date()
    private var dateFormatter = DateFormatter()
    
    func createDateLabelText() -> NSMutableAttributedString {
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMMM"
        var string = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        string += "\n"
        string += dateFormatter.string(from: date)
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor : UIColor(red: 82 / 255, green: 95 / 254, blue: 119 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        return attributedString
    }
    
    func getDates() -> [DateModel] {
        var arrayDates: [Date] = []
        var array: [DateModel] = []
        
        for i in 1...3 {
            arrayDates.append(calendar.date(byAdding: .day, value: i, to: date)!)
        }
        
        arrayDates.append(date)
        
        for i in 1...3 {
            arrayDates.append(calendar.date(byAdding: .day, value: -i, to: date)!)
        }
        
        let newArray = arrayDates.sorted()
        
        for date in newArray {
            array.append(DateModel(dayOfWeek: date.getFormettedDateString(format: "E"), dayOfMonth: date.getFormettedDateString(format: "d")))
        }
        
        return array
    }
}