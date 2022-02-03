//
//  TaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import UIKit

class TaskViewController: UIViewController {

    private lazy var logOutButton = createLogOutButton()
    
    private let authManager = FireBaseAuthManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
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
        view.addSubview(logOutButton)
        pinLogOutButton()
    }
    
    func createLogOutButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "LogOut", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }
    
    func pinLogOutButton() {
        NSLayoutConstraint.activate([
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            logOutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
