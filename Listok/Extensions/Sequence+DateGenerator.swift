//
//  Sequence+DateGenerator.swift
//  Listok
//
//  Created by Мария Манжос on 23.02.22.
//

import Foundation

extension Sequence where Iterator.Element: DateModel {
    
    func generateDates() -> [DateModel] {
        let calendar = Calendar.current
        let date = Date()
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
