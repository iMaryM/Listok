//
//  TaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import UIKit

protocol TaskViewControllerProtocol: AnyObject {

}

class TaskViewController: UIViewController, TaskViewControllerProtocol {
    
    //MARK: - property
    private lazy var taskLabel = createTaskLabel()
    private lazy var dateLabel = createDateLabel()
    private lazy var calendarCollectionView = createcalendarCollectionView()
    private lazy var todayLabel = createTodayLabel()
    private lazy var withoutTaskImageView = createWithoutTaskImageView()
    private lazy var withoutTaskLabel = createWithoutTaskLabel()
    private lazy var taskTableView = createTaskTableView()
    
    private var presenter: TaskPresenterProtocol!
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    
        withoutTaskImageView.isHidden = !presenter.getTasks().isEmpty
        withoutTaskLabel.isHidden = !presenter.getTasks().isEmpty
        
    }
    
    func setPresenter(_ presenter: TaskPresenterProtocol) {
        self.presenter = presenter
    }
    
}

//MARK: - prepare UI
private extension TaskViewController {
    
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
        label.attributedText = presenter.getAttributedStringFromCurrentDate()
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }
    
    func createcalendarCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }
    
    func pinTaskLabel() {
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            taskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24)
        ])
    }
    
    func pinDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
    }
    
    func pinCalendarCollectionView() {
        NSLayoutConstraint.activate([
            calendarCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            calendarCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            calendarCollectionView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 32),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func pinTodayLabel() {
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: 40),
            todayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24)
        ])
    }
    
    func pinWithoutTaskImageView() {
        NSLayoutConstraint.activate([
            withoutTaskImageView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 56),
            withoutTaskImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            withoutTaskImageView.heightAnchor.constraint(equalToConstant: 200),
            withoutTaskImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func pinWithoutTaskLabel() {
        NSLayoutConstraint.activate([
            withoutTaskLabel.topAnchor.constraint(equalTo: withoutTaskImageView.bottomAnchor, constant: 32),
            withoutTaskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            withoutTaskLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64)
        ])
    }
    
    func pinTaskTableView() {
        NSLayoutConstraint.activate([
            taskTableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 32),
            taskTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            taskTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    
}

//MARK: - setup CollectionView
extension TaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension TaskViewController: UICollectionViewDelegate {

    
}

extension TaskViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getDates().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let date = presenter.getDates()[indexPath.row]
        cell.setUpCell(date: date)
        
        return cell
    }
    
}

//MARK: - setup TableView
extension TaskViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        let task = presenter.getTasks()[indexPath.row]
        cell.setupCell(task)
        
        return cell
    }
    
}
