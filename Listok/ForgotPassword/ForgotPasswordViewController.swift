//
//  ForgotPasswordViewController.swift
//  Listok
//
//  Created by Мария Манжос on 2.02.22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: - property
    private lazy var forgotPasswordLabel = createForgotPasswordLabel()

    private lazy var emailIcon = createEmailIcon()
    private lazy var emailTextfield = createEmailTextfield()
    private lazy var separateLineEmail = cresteSeparateLine()
    private lazy var sendButton = createSendButton()
    private lazy var loginButton = createLoginButton()
    
    private let authManager = FireBaseAuthManager.shared
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
    }
    
    //MARK: - actions
    @objc
    private func goToLoginViewCOntroller() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func sendPassword() {
        guard let email = emailTextfield.text else {
            return
        }
        
        authManager.sendPasswordReset(withEmail: email) { result in
            switch result {
            case .success:
                let alert = UIAlertController(title: "Success", message: "Reset password email has been successfully sent", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { action in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

}

extension ForgotPasswordViewController {
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(forgotPasswordLabel)
        view.addSubview(emailIcon)
        view.addSubview(emailTextfield)
        view.addSubview(separateLineEmail)
        view.addSubview(sendButton)
        view.addSubview(loginButton)
        
        pinForgotPasswordLabel()
        pinEmailIcon()
        pinEmailTextfield()
        pinSeparateLineEmail()
        pinSendButton()
        pinLoginButton()
    }
    
    func createForgotPasswordLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Forgot password"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 32) ?? UIFont.systemFont(ofSize: 32),
            .foregroundColor : UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.numberOfLines = 1
        return label
    }
    
    func createEmailIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Lock")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createEmailTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email ID"
        return textfield
    }
    
    func cresteSeparateLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        line.layer.opacity = 0.5
        return line
    }
    
    func createSendButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Send", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(sendPassword), for: .touchUpInside)
        return button
    }
    
    func createLoginButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 44 / 255, green: 64 / 255, blue: 110 / 255, alpha: 0.7)
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Have any account? Sign In", attributes: attrs), for: .normal)
        button.addTarget(self, action: #selector(goToLoginViewCOntroller), for: .touchUpInside)
        return button
    }
    
    func pinForgotPasswordLabel() {
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            forgotPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        ])
    }
    
    func pinEmailIcon() {
        NSLayoutConstraint.activate([
            emailIcon.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 80),
            emailIcon.leadingAnchor.constraint(equalTo: forgotPasswordLabel.leadingAnchor)
        ])
    }
    
    func pinEmailTextfield() {
        NSLayoutConstraint.activate([
            emailTextfield.topAnchor.constraint(equalTo: emailIcon.topAnchor),
            emailTextfield.leftAnchor.constraint(equalTo: emailIcon.rightAnchor, constant: 12),
            emailTextfield.bottomAnchor.constraint(equalTo: emailIcon.bottomAnchor)
        ])
    }
    
    func pinSeparateLineEmail() {
        NSLayoutConstraint.activate([
            separateLineEmail.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 12),
            separateLineEmail.leadingAnchor.constraint(equalTo: emailIcon.leadingAnchor),
            separateLineEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            separateLineEmail.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinSendButton() {
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: separateLineEmail.bottomAnchor, constant: 48),
            sendButton.leadingAnchor.constraint(equalTo: separateLineEmail.leadingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: separateLineEmail.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func pinLoginButton() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
