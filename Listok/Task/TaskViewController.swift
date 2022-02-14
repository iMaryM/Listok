//
//  TaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import UIKit

class TaskViewController: UIViewController {

    private lazy var taskLabel = createTaskLabel()
    private lazy var dateLabel = createDateLabel()
    private lazy var calendarCollectionView = createcalendarCollectionView()
    
    private let taskModel = TaskModel()
    private var arrayOfDates = [DateModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        
        dateLabel.attributedText = taskModel.createDateLabelText()
        arrayOfDates = taskModel.getDates()
        
        calendarCollectionView.reloadData()
    }

}

private extension TaskViewController {
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(calendarCollectionView)
        pinTaskLabel()
        pinDateLabel()
        pinCalendarCollectionView()
    }
    
    func createTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Task"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24),
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
    
    func pinTaskLabel() {
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            taskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
    }
    
    func pinDateLabel() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    func pinCalendarCollectionView() {
        NSLayoutConstraint.activate([
            calendarCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            calendarCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            calendarCollectionView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 32),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}

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
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setUpCell(date: arrayOfDates[indexPath.row])
        
        return cell
    }
    
}
