//
//  TaskTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        tableViewCell.layer.cornerRadius = 16
    }
    
}
