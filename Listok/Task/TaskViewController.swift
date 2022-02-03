//
//  TaskViewController.swift
//  Listok
//
//  Created by Мария Манжос on 3.02.22.
//

import UIKit
import Firebase

class TaskViewController: UIViewController {

    private lazy var logOutButton = createLogOutButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    @objc
    private func logOut() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
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
