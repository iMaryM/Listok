//
//  InputTimeTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 22.02.22.
//

import UIKit

class InputTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var beginTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        beginTime.contentHorizontalAlignment = .center
        endTime.contentHorizontalAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(titleText: String) {
        titleLabel.text = titleText
    }
    
}
