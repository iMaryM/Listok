//
//  CalendarCollectionViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 8.02.22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dayOfMonthLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(dayOfWeek: String, dayOfMonth: String, isBackground: Bool) {
        
        let attrsWeeek: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        ]
        let attributedStringWeek = NSMutableAttributedString(string: dayOfWeek, attributes: attrsWeeek)
        dayOfWeekLabel.adjustsFontSizeToFitWidth = true
        dayOfWeekLabel.minimumScaleFactor = 0.5
        dayOfWeekLabel.attributedText = attributedStringWeek
                 
        let attrsMonth: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        ]
        let attributedStringMonth = NSMutableAttributedString(string: dayOfMonth, attributes: attrsMonth)
        dayOfMonthLabel.adjustsFontSizeToFitWidth = true
        dayOfMonthLabel.minimumScaleFactor = 0.5
        dayOfMonthLabel.attributedText = attributedStringMonth
        
        background.isHidden = true
        
        if isBackground {
            let attrsWeeek: [NSAttributedString.Key : Any] = [
                .font : UIFont(name: "Roboto-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20),
                .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
            ]
            let attributedStringWeek = NSMutableAttributedString(string: dayOfWeek, attributes: attrsWeeek)
            dayOfWeekLabel.adjustsFontSizeToFitWidth = true
            dayOfWeekLabel.minimumScaleFactor = 0.5
            dayOfWeekLabel.attributedText = attributedStringWeek
            
            let attrsMonth: [NSAttributedString.Key : Any] = [
                .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
                .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.4)
            ]
            let attributedStringMonth = NSMutableAttributedString(string: dayOfMonth, attributes: attrsMonth)
            dayOfMonthLabel.adjustsFontSizeToFitWidth = true
            dayOfMonthLabel.minimumScaleFactor = 0.5
            dayOfMonthLabel.attributedText = attributedStringMonth
            
            background.isHidden = false
            background.layer.cornerRadius = 12
            background.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
            dayOfWeekLabel.textColor = .white
            dayOfMonthLabel.textColor = .white
        }
    }

}
