//
//  LoginViewController.swift
//  Listok
//
//  Created by Мария Манжос on 31.01.22.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - property
    private lazy var loginLabel = createLoginLabel()
    private lazy var loginIcon = createLoginIcon()
    private lazy var loginTextfield = createLoginTextfield()
    private lazy var separateLineLogin = cresteSeparateLineLogin()
    private lazy var passwordIcon = createPasswordIcon()
    private lazy var passwordTextfield = createPasswordTextfield()
    private lazy var showIcon = createShowIcon()
    private lazy var separateLinePassword = cresteSeparateLinePassword()
    private lazy var forgotPasswordButton = createForgotPasswordButton()
    private lazy var loginButton = createLoginButton()
    private lazy var signUpButton = createSignUp()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    private func goToForgotPasswordViewCOntroller() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func goToSignUpViewCOntroller() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func goToTaskViewController() {
    }
    
}

//MARK: - prepare UI
private extension LoginViewController {
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(loginLabel)
        view.addSubview(loginIcon)
        view.addSubview(loginTextfield)
        view.addSubview(separateLineLogin)
        view.addSubview(passwordIcon)
        view.addSubview(passwordTextfield)
        view.addSubview(showIcon)
        view.addSubview(separateLinePassword)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        pinLoginLabel()
        pinLoginIcon()
        pinLoginTextfield()
        pinSeparateLineLogin()
        pinPasswordIcon()
        pinPasswordTextfield()
        pinShowIcon()
        pinSeparateLinePassword()
        pinForgotPasswordButton()
        pinLoginButton()
        pinSignUpButton()
    }
    
    func createLoginLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Login"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Bold", size: 32) ?? UIFont.systemFont(ofSize: 32),
            .foregroundColor : UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.numberOfLines = 1
        return label
    }
    
    func createLoginIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Message")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createLoginTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email ID or Username"
        return textfield
    }
    
    func cresteSeparateLineLogin() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        line.layer.opacity = 0.5
        return line
    }
    
    func createPasswordIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Lock")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createPasswordTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        return textfield
    }
    
    func createShowIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Hide")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func cresteSeparateLinePassword() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        line.layer.opacity = 0.5
        return line
    }
    
    func createForgotPasswordButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Forgot Password?", attributes: attrs), for: .normal)
        button.addTarget(self, action: #selector(goToForgotPasswordViewCOntroller), for: .touchUpInside)
        return button
    }
    
    func createLoginButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Login", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(goToTaskViewController), for: .touchUpInside)
        return button
    }
    
    func createSignUp() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 44 / 255, green: 64 / 255, blue: 110 / 255, alpha: 0.7)
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Don’t have an account? Sign Up", attributes: attrs), for: .normal)
        button.addTarget(self, action: #selector(goToSignUpViewCOntroller), for: .touchUpInside)
        return button
    }
    
    func pinLoginLabel() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        ])
    }
    
    func pinLoginIcon() {
        NSLayoutConstraint.activate([
            loginIcon.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 120),
            loginIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        ])
    }
    
    func pinLoginTextfield() {
        NSLayoutConstraint.activate([
            loginTextfield.topAnchor.constraint(equalTo: loginIcon.topAnchor),
            loginTextfield.leftAnchor.constraint(equalTo: loginIcon.rightAnchor, constant: 12),
            loginTextfield.bottomAnchor.constraint(equalTo: loginIcon.bottomAnchor)
        ])
    }
    
    func pinSeparateLineLogin() {
        NSLayoutConstraint.activate([
            separateLineLogin.topAnchor.constraint(equalTo: loginIcon.bottomAnchor, constant: 12),
            separateLineLogin.leadingAnchor.constraint(equalTo: loginIcon.leadingAnchor),
            separateLineLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            separateLineLogin.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinPasswordIcon() {
        NSLayoutConstraint.activate([
            passwordIcon.topAnchor.constraint(equalTo: separateLineLogin.bottomAnchor, constant: 32),
            passwordIcon.leadingAnchor.constraint(equalTo: separateLineLogin.leadingAnchor)
        ])
    }
    
    func pinPasswordTextfield() {
        NSLayoutConstraint.activate([
            passwordTextfield.topAnchor.constraint(equalTo: passwordIcon.topAnchor),
            passwordTextfield.leftAnchor.constraint(equalTo: passwordIcon.rightAnchor, constant: 12),
            passwordTextfield.bottomAnchor.constraint(equalTo: passwordIcon.bottomAnchor)
        ])
    }
    
    func pinShowIcon() {
        NSLayoutConstraint.activate([
            showIcon.topAnchor.constraint(equalTo: passwordTextfield.topAnchor),
            showIcon.trailingAnchor.constraint(equalTo: separateLineLogin.trailingAnchor),
            showIcon.bottomAnchor.constraint(equalTo: passwordTextfield.bottomAnchor)
        ])
    }
    
    func pinSeparateLinePassword() {
        NSLayoutConstraint.activate([
            separateLinePassword.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 12),
            separateLinePassword.leadingAnchor.constraint(equalTo: passwordIcon.leadingAnchor),
            separateLinePassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            separateLinePassword.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func pinForgotPasswordButton() {
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: separateLinePassword.bottomAnchor, constant: 12),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: separateLinePassword.trailingAnchor)
        ])
    }
    
    func pinLoginButton() {
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: separateLinePassword.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: separateLinePassword.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func pinSignUpButton() {
        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
