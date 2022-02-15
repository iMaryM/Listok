//
//  ProfileViewController.swift
//  Listok
//
//  Created by Мария Манжос on 4.02.22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - property
    lazy var emailLabel = createEmailLabel()
    private lazy var logOutButton = createLogOutButton()
    
    private let authManager = FireBaseAuthManager.shared
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    private func logOut() {
        authManager.logOut {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - prepare UI
private extension ProfileViewController {
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(emailLabel)
        view.addSubview(logOutButton)
        pinLogOutButton()
        pinEmailLabel()
    }
    
    func createEmailLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = ""
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
        
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
    
    func pinEmailLabel() {
        NSLayoutConstraint.activate([
            emailLabel.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -24),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
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
