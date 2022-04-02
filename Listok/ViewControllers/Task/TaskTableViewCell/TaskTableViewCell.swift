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
    private weak var delegate: TaskTableViewCellProtocol?
    private var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ taskModel: ListTaskModel, delegate: TaskTableViewCellProtocol, index: IndexPath) {
        taskLabel.text = taskModel.title
        timeLabel.text = taskModel.time
        contentViewCell.layer.cornerRadius = 16
        
        self.delegate = delegate
        self.index = index
    }
    
    @IBAction func showDeleteAlert(_ sender: UIButton) {
        guard let delegate = self.delegate,
              let index = self.index else { return }
        delegate.showAlert(index: index)
    }
    
}
