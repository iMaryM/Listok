//
//  TaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 18.03.22.
//

import UIKit

protocol TaskTableViewCellProtocol: AnyObject {
    func updateTask(task: TaskModel, index: IndexPath)
}

class TaskViewController: UIViewController {
    
    //MARK: - property
    private lazy var detailLabel = createDetailLabel()
    private lazy var backButton = createBackButton()
    private lazy var nameOfTaskTextField = createNameOfTaskTextField()
    private lazy var editButton = createEditButton()
    private lazy var checkButton = createCheckButton()
    private lazy var closeButton = createCloseButton()
    private lazy var dateNameLabel = createDateNameLabel()
    private lazy var dateLabel = createDateLabel()
    private lazy var dateView = createDateView()
    private lazy var timeNameLabel = createTimeNameLabel()
    private lazy var timeLabel = createTimeLabel()
    private lazy var timeView = createTimeView()
    private lazy var timeStackView = createTimeStackView()
    private lazy var taskLabel = createTaskLabel()
    private lazy var taskTableView = createTaskTableView()
    private lazy var addTaskButton = createAddTaskButton()

    private var presenter: TaskPresenterProtocol!
    
    var closure: (([TaskModel]) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    func setPresenter(presenter: TaskPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getPresenter() -> TaskPresenterProtocol? {
        return self.presenter
    }
    
    func updateTaskTable() {
        taskTableView.reloadData()
    }
    
    //MARK: - actions
    @objc
    func editNameOfTask() {
        nameOfTaskTextField.isEnabled = true
        nameOfTaskTextField.borderStyle = .roundedRect
        editButton.isHidden = true
        checkButton.isHidden = false
        closeButton.isHidden = false
    }
    
    @objc
    func saveNameOfTask() {
        nameOfTaskTextField.isEnabled = false
        nameOfTaskTextField.borderStyle = .none
        editButton.isHidden = false
        checkButton.isHidden = true
        closeButton.isHidden = true
    }
    
    @objc
    func cancelNameOfTask() {
        nameOfTaskTextField.isEnabled = false
        nameOfTaskTextField.borderStyle = .none
        editButton.isHidden = false
        checkButton.isHidden = true
        closeButton.isHidden = true
    }
    
    @objc
    func backToTaskViewController() {
        let tasks = presenter.getTasks()
        closure?(tasks)
        presenter.goToTaskList()
    }
    
    @objc
    func showAddAlert() {
        let alert = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let task = alert.textFields?.first?.text else { return }
            self.presenter.addTask(task: TaskModel(task: task))
            self.taskTableView.reloadData()
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true)
    }
    
}

//MARK: - prepare UI
extension TaskViewController {
    
    func prepareUI () {
        view.backgroundColor = .white
        view.addSubview(detailLabel)
        view.addSubview(backButton)
        view.addSubview(nameOfTaskTextField)
        view.addSubview(editButton)
        view.addSubview(checkButton)
        view.addSubview(closeButton)
        view.addSubview(timeStackView)
        view.addSubview(taskLabel)
        view.addSubview(taskTableView)
        view.addSubview(addTaskButton)

        pinDetailLabel()
        pinBackButton()
        pinNameOfTaskLabel()
        pinDateNameLabel()
        pinEditButton()
        pinCheckButton()
        pinCloseButton()
        pinDateLabel()
        pinTimeNameLabel()
        pinTimeLabel()
        pinTimeStackView()
        pinTaskLabel()
        pinTaskTableView()
        pinAddTaskButton()
    }
    
    func createDetailLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Detail"
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
        let image = UIImage(named: "chevron_left")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backToTaskViewController), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 8, height: 8)
        button.layer.shadowOpacity = 0.4
        return button
    }
    
    func createNameOfTaskTextField() -> UITextField {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        let string = "Name of task"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 27) ?? UIFont.systemFont(ofSize: 27),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        nameTextField.attributedText = attributedString
        nameTextField.textAlignment = .left
        nameTextField.isEnabled = false
        return nameTextField
    }
    
    func createEditButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "pencil")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editNameOfTask), for: .touchUpInside)
        return button
    }
    
    func createCheckButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "checkmark")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveNameOfTask), for: .touchUpInside)
        button.isHidden = true
        return button
    }
    
    func createCloseButton() -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "xmark")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelNameOfTask), for: .touchUpInside)
        button.isHidden = true
        return button
    }
    
    func createDateNameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Est. Date"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createDateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "4 march 2022"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createDateView() -> UIView {
        let dateView = UIView()
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.backgroundColor = UIColor(red: 218/255, green: 131/255, blue: 129/255, alpha: 1)
        dateView.layer.cornerRadius = 12
        dateView.addSubview(dateNameLabel)
        dateView.addSubview(dateLabel)
        return dateView
    }
    
    func createTimeNameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Est. Time"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createTimeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "07:00 - 07:30"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createTimeView() -> UIView {
        let timeView = UIView()
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.addSubview(timeNameLabel)
        timeView.addSubview(timeLabel)
        timeView.backgroundColor = UIColor(red: 218/255, green: 131/255, blue: 129/255, alpha: 1)
        timeView.layer.cornerRadius = 12
        return timeView
    }
    
    func createTimeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(dateView)
        stackView.addArrangedSubview(timeView)
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Task"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 21) ?? UIFont.systemFont(ofSize: 21),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createTaskTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    func createAddTaskButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 114/255, green: 121/255, blue: 206/255, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(showAddAlert), for: .touchUpInside)
        return button
    }
    
    func pinDetailLabel() {
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    func pinNameOfTaskLabel() {
        NSLayoutConstraint.activate([
            nameOfTaskTextField.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            nameOfTaskTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24)
        ])
    }
    
    func pinEditButton() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: nameOfTaskTextField.topAnchor),
            editButton.bottomAnchor.constraint(equalTo: nameOfTaskTextField.bottomAnchor),
            editButton.leftAnchor.constraint(equalTo: nameOfTaskTextField.rightAnchor, constant: 8),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor)
        ])
    }
    
    func pinCheckButton() {
        NSLayoutConstraint.activate([
        checkButton.topAnchor.constraint(equalTo: nameOfTaskTextField.topAnchor),
        checkButton.bottomAnchor.constraint(equalTo: nameOfTaskTextField.bottomAnchor),
        checkButton.leftAnchor.constraint(equalTo: nameOfTaskTextField.rightAnchor, constant: 8),
        checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor)
        ])
    }
    
    func pinCloseButton() {
        NSLayoutConstraint.activate([
        closeButton.topAnchor.constraint(equalTo: checkButton.topAnchor),
        closeButton.bottomAnchor.constraint(equalTo: checkButton.bottomAnchor),
        closeButton.leftAnchor.constraint(equalTo: checkButton.rightAnchor, constant: 8),
        closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ])
    }
    
    func pinDateNameLabel() {
        NSLayoutConstraint.activate([
            dateNameLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 16),
            dateNameLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor, constant: 16),
            dateNameLabel.rightAnchor.constraint(equalTo: dateView.rightAnchor, constant: -16)
        ])
    }
    
    func pinDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dateNameLabel.bottomAnchor, constant: 4),
            dateLabel.leftAnchor.constraint(equalTo: dateView.leftAnchor, constant: 16),
            dateLabel.rightAnchor.constraint(equalTo: dateView.rightAnchor, constant: -16)
        ])
    }
    
    func pinTimeNameLabel() {
        NSLayoutConstraint.activate([
            timeNameLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 16),
            timeNameLabel.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 16),
            timeNameLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor, constant: -16)
        ])
    }
    
    func pinTimeLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: timeNameLabel.bottomAnchor, constant: 4),
            timeLabel.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 16),
            timeLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor, constant: -16)
        ])
    }
    
    func pinTimeStackView() {
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: nameOfTaskTextField.bottomAnchor,constant: 32),
            timeStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            timeStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            timeStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func pinTaskLabel() {
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 32),
            taskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            taskLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
    }
    
    func pinTaskTableView() {
        NSLayoutConstraint.activate([
            taskTableView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 16),
            taskTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            taskTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
    
    func pinAddTaskButton() {
        NSLayoutConstraint.activate([
            addTaskButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            addTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            addTaskButton.widthAnchor.constraint(equalToConstant: 50),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

//MARK: - setup tableView
extension TaskViewController: UITableViewDelegate {
    
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(task: presenter.getTasks()[indexPath.row], delegate: self, index: indexPath)
        
        return cell
    }
}

extension TaskViewController: TaskTableViewCellProtocol {
    func updateTask(task: TaskModel, index: IndexPath) {
        self.presenter.updateTask(task: task, taskIndex: index.row)
    }
}
