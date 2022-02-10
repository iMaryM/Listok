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
    
    private var date = Date()
    private var dateFormatter = DateFormatter()
    
    private let authManager = FireBaseAuthManager.shared
    
    private let calendar = Calendar.current
    
    private var arrayOfDates: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        
        arrayOfDates = getDates(from: date)
        
    }
    
    @objc
    private func logOut() {
        authManager.logOut {
            self.navigationController?.popToRootViewController(animated: true)
        }
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
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMMM"
        var string = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        string += "\n"
        string += dateFormatter.string(from: date)
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor : UIColor(red: 82 / 255, green: 95 / 254, blue: 119 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
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

private extension TaskViewController {
    func getDates(from date: Date) -> [Date] {
        var array: [Date] = []
        
        for i in 1...3 {
            array.append(calendar.date(byAdding: .day, value: i, to: date)!)
        }
        
        array.append(date)
        
        for i in 1...3 {
            array.append(calendar.date(byAdding: .day, value: -i, to: date)!)
        }
        
        return array.sorted()
    }
    
    func convertDateToString(_ date: Date) -> (dayOfWeek: String, dayOfMonth: String) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en")
        dateFormatter1.dateFormat = "E"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = Locale(identifier: "en")
        dateFormatter2.dateFormat = "d"
        return (dateFormatter1.string(from: date), dateFormatter2.string(from: date))
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
        
        if date == arrayOfDates[indexPath.row] {
            cell.setUpCell(dayOfWeek: convertDateToString(arrayOfDates[indexPath.row]).dayOfWeek , dayOfMonth: convertDateToString(arrayOfDates[indexPath.row]).dayOfMonth, isBackground: true)
        } else {
            cell.setUpCell(dayOfWeek: convertDateToString(arrayOfDates[indexPath.row]).dayOfWeek , dayOfMonth: convertDateToString(arrayOfDates[indexPath.row]).dayOfMonth, isBackground: false)
        }
        
        return cell
    }
    
}
