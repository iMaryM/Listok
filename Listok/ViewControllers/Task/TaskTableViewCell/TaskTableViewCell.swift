//
//  TaskTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ taskModel: TaskModel) {
        taskLabel.text = taskModel.title
        timeLabel.text = taskModel.time
        contentViewCell.layer.cornerRadius = 16
    }
}
