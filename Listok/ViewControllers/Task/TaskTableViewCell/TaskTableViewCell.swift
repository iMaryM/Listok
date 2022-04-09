//
//  TaskTableViewCell.swift
//  Listok
//
//  Created by Мария Манжос on 2.04.22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    private weak var delegate: TaskTableViewCellProtocol?
    private var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkBox.layer.borderColor = UIColor.lightGray.cgColor
        checkBox.layer.borderWidth = 1
        checkBox.layer.cornerRadius = 8
        checkBox.setImage(nil, for: .normal)
        checkBox.setImage(UIImage(named: "checkbox"), for: .selected)
        checkBox.imageView?.contentMode = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(task: TaskModel, delegate: TaskTableViewCellProtocol, index: IndexPath) {
        taskLabel.text = task.task
        checkBox.isSelected = task.isDone
        self.delegate = delegate
        self.index = index
    }
    
    @IBAction func checkboxAction(_ sender: UIButton) {
        checkBox.isSelected = !checkBox.isSelected
        guard let task = taskLabel.text,
              let delegate = self.delegate,
              let index = self.index else {
            return
        }
        delegate.updateTask(task: TaskModel(task: task, isDone: checkBox.isSelected), index: index)
    }
    
}
