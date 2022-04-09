//
//  AddTaskListViewController.swift
//  Listok
//
//  Created by Мария Манжос on 22.02.22.
//

import UIKit

class AddTaskListViewController: UIViewController {

    //MARK: - property
    private lazy var addTaskLabel = createAddTaskLabel()
    private lazy var backButton = createBackButton()
    private lazy var titleLabel = createLabel(text: "Title")
    private lazy var inputTitleTextfield = createInputTextfield(placeholder: "Input title of new task")
    private lazy var titleSeparatorLine = createSeparatorLine()
    private lazy var dateLabel = createLabel(text: "Date")
    private lazy var inputDate = createInputDate()
    private lazy var dateSeparatorLine = createSeparatorLine()
    private lazy var timeLabel = createLabel(text: "Time")
    private lazy var beginTimeView = createBeginTimeView()
    private lazy var inputBeginTime = createInputBeginTime()
    private lazy var beginTimeSeparatorLine = createSeparatorLine()
    private lazy var endTimeView = createEndTimeView()
    private lazy var inputEndTime = createInputBeginTime()
    private lazy var endTimeSeparatorLine = createSeparatorLine()
    private lazy var timeStackView = createTimeStackView()
    private lazy var descriptionLabel = createLabel(text: "Description")
    private lazy var descriptionTextField = createInputTextfield(placeholder: "Input description of new task")
    private lazy var descriptionSeparatorLine = createSeparatorLine()
    private lazy var addButton = createAddButton()
    
    var closure: ((TaskListModel) -> ())?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    func dismissAddTaskViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func addTask() {
        guard let title = inputTitleTextfield.text else {return}
        let beginTime = inputBeginTime.date.getFormettedDateString(format: "HH:mm")
        let endTime = inputBeginTime.date.getFormettedDateString(format: "HH:mm")
        let task = TaskListModel(title: title, time: "\(beginTime) - \(endTime)")
        
        closure?(task)
        
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - prepare UI
private extension AddTaskListViewController {
    func prepareUI () {
        view.backgroundColor = .white
        view.addSubview(addTaskLabel)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(inputTitleTextfield)
        view.addSubview(titleSeparatorLine)
        view.addSubview(dateLabel)
        view.addSubview(inputDate)
        view.addSubview(dateSeparatorLine)
        view.addSubview(timeLabel)
        view.addSubview(timeStackView)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(descriptionSeparatorLine)
        
        view.addSubview(addButton)
        pinAddTaskLabel()
        pinBackButton()
        pinTitleLabel()
        pinInputTitleTextField()
        pinTitleSeparatorLine()
        pinDateLabel()
        pinInputDate()
        pinDateSeparatorLine()
        pinTimeLabel()
        pinInputBeginTime()
        pinBeginTimeSeparatorLine()
        pinInputEndTime()
        pinEndTimeSeparatorLine()
        pinTimeStackView()
        pinDescriptionLabel()
        pinDescriptionTextField()
        pinDescriptionSeparatorLine()
        
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
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = text
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 138 / 255, green: 139 / 254, blue: 179 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createInputTextfield(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        return textField
    }
    
    func createSeparatorLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        line.layer.opacity = 0.5
        return line
    }
    
    func createInputDate() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.locale = Locale(identifier: "en")
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .left
        return datePicker
    }
    
    func createInputBeginTime() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.locale = Locale(identifier: "en")
        datePicker.datePickerMode = .time
        datePicker.contentHorizontalAlignment = .center
        return datePicker
    }
    
    func createBeginTimeView() -> UIView {
        let beginTimeView = UIView()
        beginTimeView.translatesAutoresizingMaskIntoConstraints = false
        beginTimeView.addSubview(inputBeginTime)
        beginTimeView.addSubview(beginTimeSeparatorLine)
        return beginTimeView
    }
    
    func createEndTimeView() -> UIView {
        let endTimeView = UIView()
        endTimeView.translatesAutoresizingMaskIntoConstraints = false
        endTimeView.addSubview(inputEndTime)
        endTimeView.addSubview(endTimeSeparatorLine)
        return endTimeView
    }
    
    func createTimeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(beginTimeView)
        stackView.addArrangedSubview(endTimeView)
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
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
    
    func pinTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
    }
    
    func pinInputTitleTextField() {
        NSLayoutConstraint.activate([
            inputTitleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            inputTitleTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            inputTitleTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            inputTitleTextfield.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func pinTitleSeparatorLine() {
        NSLayoutConstraint.activate([
            titleSeparatorLine.topAnchor.constraint(equalTo: inputTitleTextfield.bottomAnchor, constant: 16),
            titleSeparatorLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            titleSeparatorLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            titleSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleSeparatorLine.bottomAnchor, constant: 24),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    func pinInputDate() {
        NSLayoutConstraint.activate([
            inputDate.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            inputDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            inputDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    func pinDateSeparatorLine() {
        NSLayoutConstraint.activate([
            dateSeparatorLine.topAnchor.constraint(equalTo: inputDate.bottomAnchor, constant: 16),
            dateSeparatorLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            dateSeparatorLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            dateSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinTimeLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: dateSeparatorLine.bottomAnchor, constant: 24),
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    func pinInputBeginTime() {
        NSLayoutConstraint.activate([
            inputBeginTime.topAnchor.constraint(equalTo: beginTimeView.topAnchor),
            inputBeginTime.leftAnchor.constraint(equalTo: beginTimeView.leftAnchor),
            inputBeginTime.rightAnchor.constraint(equalTo: beginTimeView.rightAnchor)
        ])
    }
    
    func pinBeginTimeSeparatorLine() {
        NSLayoutConstraint.activate([
            beginTimeSeparatorLine.topAnchor.constraint(equalTo: inputBeginTime.bottomAnchor, constant: 16),
            beginTimeSeparatorLine.leadingAnchor.constraint(equalTo: inputBeginTime.leadingAnchor),
            beginTimeSeparatorLine.trailingAnchor.constraint(equalTo: inputBeginTime.trailingAnchor),
            beginTimeSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinInputEndTime() {
        NSLayoutConstraint.activate([
            inputEndTime.topAnchor.constraint(equalTo: endTimeView.topAnchor),
            inputEndTime.leftAnchor.constraint(equalTo: endTimeView.leftAnchor),
            inputEndTime.rightAnchor.constraint(equalTo: endTimeView.rightAnchor)
        ])
    }
    
    func pinEndTimeSeparatorLine() {
        NSLayoutConstraint.activate([
            endTimeSeparatorLine.topAnchor.constraint(equalTo: inputEndTime.bottomAnchor, constant: 16),
            endTimeSeparatorLine.trailingAnchor.constraint(equalTo: inputEndTime.trailingAnchor),
            endTimeSeparatorLine.leadingAnchor.constraint(equalTo: inputEndTime.leadingAnchor),
            endTimeSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinTimeStackView() {
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timeStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            timeStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            timeStackView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func pinDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 16),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    func pinDescriptionTextField() {
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            descriptionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func pinDescriptionSeparatorLine() {
        NSLayoutConstraint.activate([
            descriptionSeparatorLine.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 16),
            descriptionSeparatorLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            descriptionSeparatorLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            descriptionSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinAddButton() {
        NSLayoutConstraint.activate([
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
}
