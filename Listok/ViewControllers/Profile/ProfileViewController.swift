//
//  ProfileViewController.swift
//  Listok
//
//  Created by Мария Манжос on 4.02.22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - property
    lazy var avatarView = createAvatarView()
    lazy var avatarImageView = createAvatarImageView()
    lazy var usernameLabel = createUsernameLabel()
    lazy var emailLabel = createEmailLabel()
    private lazy var logOutButton = createLogOutButton()
    
    private let authService: AuthServiceProtocol
    private let router: ProfileRouterProtocol
    
    //MARK: - initializer
    init(authService: AuthServiceProtocol, router: ProfileRouterProtocol) {
        self.authService = authService
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    private func logOut() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure to log out from this account ?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let sureButton = UIAlertAction(title: "Sure", style: .default) { _ in
            self.authService.logOut {
                self.router.perform(segue: .goToLogin, viewController: self)
            }
        }
        alert.addAction(cancelButton)
        alert.addAction(sureButton)
        present(alert, animated: true, completion: nil)
    }

}

//MARK: - prepare UI
private extension ProfileViewController {
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(avatarView)
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(logOutButton)
        pinAvatarView()
        pinAvatarImageView()
        pinUsernameLabel()
        pinEmailLabel()
        pinLogOutButton()
    }
    
    func createAvatarView() -> UIView {
        let viewAvatar = UIView()
        viewAvatar.translatesAutoresizingMaskIntoConstraints = false
        viewAvatar.backgroundColor = .white
        viewAvatar.layer.cornerRadius = 40
        viewAvatar.layer.shadowColor = UIColor.lightGray.cgColor
        viewAvatar.layer.shadowOpacity = 0.5
        viewAvatar.layer.shadowOffset = CGSize(width: 8, height: 8)
        viewAvatar.layer.shadowRadius = 8
        return viewAvatar
    }
    
    func createAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func createUsernameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "username"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }
    
    func createEmailLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "email"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18),
            .foregroundColor : UIColor(red: 16 / 255, green: 39 / 254, blue: 90 / 255, alpha: 1)
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
    
    func pinAvatarView() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 80),
            avatarView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func pinAvatarImageView() {
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ])
    }
    
    func pinUsernameLabel() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 24),
            usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
    }
    
    func pinEmailLabel() {
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 12),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
    }
    
    func pinLogOutButton() {
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            logOutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
