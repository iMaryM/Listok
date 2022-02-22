//
//  InputDateTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 22.02.22.
//

import UIKit

class InputDateTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(titleText: String) {
        titleLabel.text = titleText
    }
    
    @IBAction func setDateValue(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "d MMMM YYYY"
        dateLabel.text = formatter.string(from: sender.date)
    }

}
