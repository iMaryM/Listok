//
//  SignUpViewController.swift
//  Listok
//
//  Created by Мария Манжос on 31.01.22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    //MARK: - property
    private lazy var signUpLabel = createSignUpLabel()
    private lazy var loginIcon = createLoginIcon()
    private lazy var loginTextfield = createLoginTextfield()
    private lazy var separateLineLogin = cresteSeparateLine()
    private lazy var emailIcon = createEmailIcon()
    private lazy var emailTextfield = createEmailTextfield()
    private lazy var separateLineEmail = cresteSeparateLine()
    private lazy var passwordIcon = createPasswordIcon()
    private lazy var passwordTextfield = createPasswordTextfield()
    private lazy var separateLinePassword = cresteSeparateLine()
    private lazy var createButton = createCreateButton()
    
    private lazy var loginButton = createLoginButton()
    
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
    private func createProfile() {
        
        guard let email = emailTextfield.text,
              let password = passwordTextfield.text else {
                  return
              }
        
//        FireBaseAuthManager.shared.authentication(with: email, and: password)
        
        //если создали аккаунт успешно то логинимся и переходим на экрна таск
        //если свалилась ошибка, то показать алерт с ошибкой
        
        //некрасиво, надо сделать красиво через менеджер. Но не придумала как(
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("error = \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let result = authResult {
                    print("UserID = \(result.user.uid)")
                    
                    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                      guard let strongSelf = self else { return }
                        if let error = error {
                            print("error = \(error.localizedDescription)")
                            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            strongSelf.present(alert, animated: true, completion: nil)
                        } else {
                            if let result = authResult {
                                print("UserID = \(result.user.uid)")
                                
                                let vc = TaskViewController()
                                strongSelf.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension SignUpViewController {
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(signUpLabel)
        view.addSubview(loginIcon)
        view.addSubview(loginTextfield)
        view.addSubview(separateLineLogin)
        view.addSubview(emailIcon)
        view.addSubview(emailTextfield)
        view.addSubview(separateLineEmail)
        view.addSubview(passwordIcon)
        view.addSubview(passwordTextfield)
        view.addSubview(separateLinePassword)
        view.addSubview(createButton)
        view.addSubview(loginButton)
        
        pinSignUpLabel()
        pinLoginIcon()
        pinLoginTextfield()
        pinSeparateLineLogin()
        pinEmailIcon()
        pinEmailTextfield()
        pinSeparateLineEmail()
        pinPasswordIcon()
        pinPasswordTextfield()
        pinSeparateLinePassword()
        pinCreateButton()
        pinLoginButton()
    }
    
    func createSignUpLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Sign Up"
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
        textfield.placeholder = "Username"
        return textfield
    }
    
    func cresteSeparateLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        line.layer.opacity = 0.5
        return line
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
    
    func createCreateButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Create", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(createProfile), for: .touchUpInside)
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
    
    func pinSignUpLabel() {
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40)
        ])
    }
    
    func pinLoginIcon() {
        NSLayoutConstraint.activate([
            loginIcon.topAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: 80),
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
    
    func pinEmailIcon() {
        NSLayoutConstraint.activate([
            emailIcon.topAnchor.constraint(equalTo: separateLineLogin.bottomAnchor, constant: 32),
            emailIcon.leadingAnchor.constraint(equalTo: separateLineLogin.leadingAnchor)
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

    func pinPasswordIcon() {
        NSLayoutConstraint.activate([
            passwordIcon.topAnchor.constraint(equalTo: separateLineEmail.bottomAnchor, constant: 32),
            passwordIcon.leadingAnchor.constraint(equalTo: separateLineEmail.leadingAnchor)
        ])
    }
    
    func pinPasswordTextfield() {
        NSLayoutConstraint.activate([
            passwordTextfield.topAnchor.constraint(equalTo: passwordIcon.topAnchor),
            passwordTextfield.leftAnchor.constraint(equalTo: passwordIcon.rightAnchor, constant: 12),
            passwordTextfield.bottomAnchor.constraint(equalTo: passwordIcon.bottomAnchor)
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
    
    func pinCreateButton() {
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: separateLinePassword.bottomAnchor, constant: 48),
            createButton.leadingAnchor.constraint(equalTo: separateLinePassword.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: separateLinePassword.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func pinLoginButton() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
