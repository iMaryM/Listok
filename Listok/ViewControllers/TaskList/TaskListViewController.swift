//
//  TaskListViewController.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import UIKit
import DateScrollPicker

protocol TaskListTableViewCellProtocol: AnyObject {
    func showAlert(index: IndexPath)
}

protocol TaskListViewControllerProtocol: AnyObject {
    func updateTaskTable()
}

protocol TaskListViewControllerDelegate: UIViewController {
    func addTaskList(taskList: TaskListModel)
}

class TaskListViewController: UIViewController {
    
    //MARK: - property
    private lazy var taskLabel = createTaskLabel()
    private lazy var dateLabel = createDateLabel()
    private lazy var calendarCollectionView = createcalendarCollectionView()
    private lazy var todayLabel = createTodayLabel()
    private lazy var withoutTaskImageView = createWithoutTaskImageView()
    private lazy var withoutTaskLabel = createWithoutTaskLabel()
    private lazy var taskTableView = createTaskTableView()
    
    private var presenter: TaskListPresenterProtocol!
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()

        withoutTaskImageView.isHidden = !presenter.getTaskLists().isEmpty
        withoutTaskLabel.isHidden = !presenter.getTaskLists().isEmpty
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            guard let self = self else { return }
            self.calendarCollectionView.selectToday(animated: false)
        }
    }
    
    func setPresenter(_ presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
    }
    
}

//MARK: - prepare UI
private extension TaskListViewController {
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(calendarCollectionView)
        view.addSubview(todayLabel)
        view.addSubview(taskTableView)
        view.addSubview(withoutTaskImageView)
        view.addSubview(withoutTaskLabel)
        pinTaskLabel()
        pinDateLabel()
        pinCalendarCollectionView()
        pinTodayLabel()
        pinTaskTableView()
        pinWithoutTaskImageView()
        pinWithoutTaskLabel()
    }
    
    func createTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Task"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
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
        label.attributedText = Date().getAttributedStringDate()
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }
    
    func createcalendarCollectionView() -> DateScrollPicker {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionViewCell")
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        return collectionView
        let dateScrollPicker = DateScrollPicker()
        dateScrollPicker.translatesAutoresizingMaskIntoConstraints = false
        var format = DateScrollPickerFormat()

        /// Number of days
        format.days = 7
        
        /// Top label date format
        format.topDateFormat = "MMMM"
        /// Top label font
        format.topFont = UIFont(name: "Roboto-Regular", size: 9) ?? UIFont.systemFont(ofSize: 9)
        /// Top label text color
        format.topTextColor = UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        /// Top label selected text color
        format.topTextSelectedColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)

        // Medium label date format
        format.mediumDateFormat = "dd"
        /// Medium label font
        format.mediumFont = UIFont(name: "Roboto-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15)
        /// Medium label text color
        format.mediumTextColor = UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        /// Medium label selected text color
        format.mediumTextSelectedColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.4)
        
        /// Bottom label date format
        format.bottomDateFormat = "EEE"
        /// Bottom label font
        format.bottomFont = UIFont(name: "Roboto-Regular", size: 9) ?? UIFont.systemFont(ofSize: 9)
        /// Bottom label text color
        format.bottomTextColor = UIColor(red: 16 / 255, green: 38 / 255, blue: 90 / 255, alpha: 1)
        /// Bottom label selected text color
        format.bottomTextSelectedColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)

        /// Day radius
        format.dayRadius = 12

        /// Day background color
        format.dayBackgroundColor = .clear

        /// Day background selected color
        format.dayBackgroundSelectedColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)

        /// Selection animation
        format.animatedSelection = true

        /// Separator enabled
        format.separatorEnabled = true

        /// Separator top label date format
        format.separatorTopDateFormat = "MMM"

        /// Separator top label font
        format.separatorTopFont = UIFont.systemFont(ofSize: 4, weight: .bold)

        /// Separator top label text color
        format.separatorTopTextColor = UIColor.black

        /// Separator bottom label date format
        format.separatorBottomDateFormat = "yyyy"

        /// Separator bottom label font
        format.separatorBottomFont = UIFont.systemFont(ofSize: 4, weight: .regular)

        /// Separator bottom label text color
        format.separatorBottomTextColor = UIColor.black

        /// Separator background color
        format.separatorBackgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

        /// Fade enabled
        format.fadeEnabled = false

//        /// Animation scale factor
//        format.animationScaleFactor = 1.1

        /// Animation scale factor
        format.dayPadding = 4

        /// Top margin data label
        format.topMarginData = 8

        /// Dot view size
        format.dotWidth = 8

        dateScrollPicker.format = format
        
        dateScrollPicker.delegate = self
        dateScrollPicker.dataSource = self
        
        //dateScrollPicker.selectToday(animated: true)
        
        return dateScrollPicker
    }
    
    func createTodayLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Today"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }
    
    func createWithoutTaskImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "withoutTask")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createWithoutTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "You don’t have any schedule today.\n Tap the plus button to create new to-do."
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor : UIColor(red: 87 / 255, green: 87 / 254, blue: 87 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    func createTaskTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "TaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    
    func pinTaskLabel() {
        let heightStatusBar = UIApplication.shared.statusBarFrame.size.height
        
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: heightStatusBar),
            taskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            taskLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func pinDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: taskLabel.centerYAnchor),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
    }
    
    func pinCalendarCollectionView() {
        NSLayoutConstraint.activate([
            calendarCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            calendarCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            calendarCollectionView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 16),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func pinTodayLabel() {
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: 16),
            todayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            todayLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func pinWithoutTaskImageView() {
        NSLayoutConstraint.activate([
            withoutTaskImageView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 16),
            withoutTaskImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            withoutTaskImageView.heightAnchor.constraint(equalToConstant: 150),
            withoutTaskImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func pinWithoutTaskLabel() {
        NSLayoutConstraint.activate([
            withoutTaskLabel.topAnchor.constraint(equalTo: withoutTaskImageView.bottomAnchor, constant: 24),
            withoutTaskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            withoutTaskLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64),
            withoutTaskLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -116)
        ])
    }
    
    func pinTaskTableView() {
        NSLayoutConstraint.activate([
            taskTableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 16),
            taskTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            taskTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
}

//MARK: - setup DateScrollPicker
extension TaskListViewController: DateScrollPickerDelegate {
    
}

extension TaskListViewController: DateScrollPickerDataSource {
    // Returns custom color for dot view
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, dotColorByDate date: Date) -> UIColor? {
        return UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.7)
    }
}

//MARK: - setup TableView
extension TaskListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
}

extension TaskListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTaskLists().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListTableViewCell") as? TaskListTableViewCell else {
            return UITableViewCell()
        }

        let task = presenter.getTaskLists()[indexPath.row]
        cell.setupCell(task, delegate: self, index: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskFactory().create()
        let taskList = presenter.getTaskLists()[indexPath.row]
        vc.getPresenter()?.setTasks(tasks: presenter.getTasks(from: taskList))
        vc.closure = { task in
            self.presenter.setTasks(indexTaskList: indexPath.row, tasks: task)
        }
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension TaskListViewController: TaskListViewControllerDelegate {
    func addTaskList(taskList: TaskListModel) {
        presenter.addTaskLists(taskList: taskList)
    }
}

extension TaskListViewController: TaskListViewControllerProtocol {
    func updateTaskTable() {
        withoutTaskImageView.isHidden = !presenter.getTaskLists().isEmpty
        withoutTaskLabel.isHidden = !presenter.getTaskLists().isEmpty
        taskTableView.reloadData()
    }
}

extension TaskListViewController: TaskListTableViewCellProtocol {
    func showAlert(index: IndexPath) {
        let alert = UIAlertController(title: "Delete", message: "Do you want delete cell?", preferredStyle: .alert)
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.presenter.deleteTaskList(taskListIndex: index.row)
        }
        let actionCencel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(actionDelete)
        alert.addAction(actionCencel)
        self.present(alert, animated: true, completion: nil)
    }
}
