//
//  AddTaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 22.02.22.
//

import UIKit

class AddTaskViewController: UIViewController {

    private lazy var addTaskLabel = createAddTaskLabel()
    private lazy var backButton = createBackButton()
    private lazy var addTaskTableView = createAddTaskTableView()
    private lazy var addButton = createAddButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    @objc
    func dismissAddTaskViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func addTask() {
        
    }
    
}

private extension AddTaskViewController {
    func prepareUI () {
        view.backgroundColor = .white
        view.addSubview(addTaskLabel)
        view.addSubview(backButton)
        view.addSubview(addTaskTableView)
        view.addSubview(addButton)
        pinAddTaskLabel()
        pinBackButton()
        pinAddTaskTableView()
        pinAddButton()
    }
    
    func createAddTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Add Task"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }
    
    func createBackButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "chevron_down")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissAddTaskViewController), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 8, height: 8)
        button.layer.shadowOpacity = 0.4
        return button
    }
    
    func createAddTaskTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "InputTextTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTextTableViewCell")
        tableView.register(UINib(nibName: "InputDateTableViewCell", bundle: nil), forCellReuseIdentifier: "InputDateTableViewCell")
        tableView.register(UINib(nibName: "InputTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTimeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }
    
    func createAddButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Add", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return button
    }
    
    func pinAddTaskLabel() {
        NSLayoutConstraint.activate([
            addTaskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            addTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func pinBackButton() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func pinAddTaskTableView() {
        NSLayoutConstraint.activate([
            addTaskTableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            addTaskTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            addTaskTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            addTaskTableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: 24)
        ])
    }
    
    func pinAddButton() {
        NSLayoutConstraint.activate([
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
}

extension AddTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
}

extension AddTaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let inputTextCell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as? InputTextTableViewCell,
              let inputDateCell = tableView.dequeueReusableCell(withIdentifier: "InputDateTableViewCell") as? InputDateTableViewCell,
              let inputTimeCell = tableView.dequeueReusableCell(withIdentifier: "InputTimeTableViewCell") as? InputTimeTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            inputTextCell.setup(titleText: "Title", placeholderText: "Input name of new task")
            return inputTextCell
        case 1:
            inputDateCell.setup(titleText: "Date")
            return inputDateCell
        case 2:
            inputTimeCell.setup(titleText: "Time")
            return inputTimeCell
        case 3:
            inputTextCell.setup(titleText: "Description", placeholderText: "Input description of task")
            return inputTextCell
        default:
            return UITableViewCell()
        }

    }
    
    
}
