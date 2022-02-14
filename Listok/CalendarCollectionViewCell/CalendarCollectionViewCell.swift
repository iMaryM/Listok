//
//  CalendarCollectionViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 8.02.22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    enum DateType {
        case dayOfWeek
        case dayOfMonth
    }

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dayOfMonthLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    private let currentDate = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(date: DateModel) {
        
        let isSelectedCell: Bool = currentDate.getCurrentDateString(format: "d") == date.dayOfMonth
        
        setupLabel(dayOfWeekLabel, isSelectedCell: isSelectedCell, date: date.dayOfWeek)
        setupLabel(dayOfMonthLabel, isSelectedCell: isSelectedCell, date: date.dayOfMonth)
    
        background.isHidden = !isSelectedCell
        
        if isSelectedCell {
            background.layer.cornerRadius = 12
            background.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        }
    }
}

private extension CalendarCollectionViewCell {
    
    func setupLabel(_ label: UILabel, isSelectedCell: Bool, date: String) {
        let attrs: [NSAttributedString.Key : Any] = [
            .font : FormattedString.mediumText(isSelected: isSelectedCell).font,
            .foregroundColor : FormattedString.mediumText(isSelected: isSelectedCell).fontColor
        ]
        
        let attributedString = NSMutableAttributedString(string: date, attributes: attrs)
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.attributedText = attributedString
    }
    
    func convertDateToString(_ date: Date, type: DateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        
        switch type {
        case .dayOfWeek:
            dateFormatter.dateFormat = "E"
        case .dayOfMonth:
            dateFormatter.dateFormat = "d"
        }

        return dateFormatter.string(from: date)
    }

}

extension Date {
    func getCurrentDateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
