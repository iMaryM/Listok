//
//  InputTextTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 22.02.22.
//

import UIKit

class InputTextTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(titleText: String, placeholderText: String) {
        titleLabel.text = titleText
        inputTextField.placeholder = placeholderText
    }
    
}
