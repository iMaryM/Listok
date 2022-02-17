//
//  SignUpViewController.swift
//  Listok
//
//  Created by Мария Манжос on 31.01.22.
//

import UIKit

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
    
    private let authService: AuthServiceProtocol
    private let router: SignUpRouterProtocol
    
    //MARK: - initializer
    init(authService: AuthServiceProtocol, router: SignUpRouterProtocol) {
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
    private func goToLoginViewCOntroller() {
        router.perform(to: .goToLogin, viewController: self)
    }
    
    @objc
    private func createProfile() {
        
        guard let email = emailTextfield.text,
              let password = passwordTextfield.text else {
                  return
              }
        
        authService.createUser(email: email, password: password) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.authService.signIn(email: email, password: password) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    switch result {
                    case .success:
                        
                        if (self.checkSavedCredential()) {
                            UserDefaults.standard.removeObject(forKey: KeyesUserDefaults.email.rawValue)
                            UserDefaults.standard.removeObject(forKey: KeyesUserDefaults.password.rawValue)
                        }
                        
                        UserDefaults.standard.setValue(email, forKey: KeyesUserDefaults.email.rawValue)
                        UserDefaults.standard.setValue(password, forKey: KeyesUserDefaults.password.rawValue)
                        
                        
                        self.router.perform(to: .goToTask, viewController: self)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - prepare UI
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

//MARK: - check UserDefaults
private extension SignUpViewController {
    func checkSavedCredential() -> Bool {
        return ((UserDefaults.standard.value(forKey: KeyesUserDefaults.email.rawValue) != nil) || (UserDefaults.standard.value(forKey: KeyesUserDefaults.password.rawValue) != nil))
    }
}
