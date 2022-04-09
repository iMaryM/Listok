//
//  TaskListTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private weak var delegate: TaskListTableViewCellProtocol?
    private var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ taskListModel: TaskListModel, delegate: TaskListTableViewCellProtocol, index: IndexPath) {
        taskLabel.text = taskListModel.title
        timeLabel.text = taskListModel.time
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
