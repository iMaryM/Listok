//
//  ViewController.swift
//  Listok
//
//  Created by Мария Манжос on 29.01.22.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - property
    private lazy var mainIconImage = createMainIconImage()
    private lazy var iconImage = createIconImage()
    private lazy var descriptionLabel = createDescriptionLabel()
    private lazy var buttonSignUp = createButtonSignUp()
    private lazy var buttonLogin = createButtonLogin()
    
    private let router: SplashRouterProtocol = SplashRouter()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    private func buttonSignUpAction() {
        router.perform(to: .goToSignUp, viewController: self)
    }
    
    @objc
    private func buttonLoginAction() {
        router.perform(to: .goToLogin, viewController: self)
    }
}

//MARK: - prepare UI
private extension SplashViewController {
    func prepareUI() {
        view.addSubview(mainIconImage)
        view.addSubview(iconImage)
        view.addSubview(descriptionLabel)
        view.addSubview(buttonSignUp)
        view.addSubview(buttonLogin)
        pinMainImage()
        pinIconImage()
        pinDescriptionLabel()
        pinButtonSignUp()
        pinButtonLogin()
    }
    
    func createMainIconImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "vector 1 1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createIconImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Group 5")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let string = "Plan what you will do to be more organized for\n today, tomorrow and beyond"
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 44 / 255, green: 64 / 255, blue: 110 / 255, alpha: 1)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attrs)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func createButtonSignUp() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Sign Up", attributes: attrs), for: .normal)
        button.addTarget(self, action: #selector(buttonSignUpAction), for: .touchUpInside)
        return button
    }
    
    func createButtonLogin() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Roboto-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.white
        ]
        button.setAttributedTitle(NSMutableAttributedString(string: "Login", attributes: attrs), for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buttonLoginAction), for: .touchUpInside)
        return button
    }
    
    func pinMainImage () {
        NSLayoutConstraint.activate([
            mainIconImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            mainIconImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64),
            mainIconImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64)
        ])
    }
    
    func pinIconImage() {
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.topAnchor.constraint(equalTo: mainIconImage.bottomAnchor, constant: 48)
        ])
    }
    
    func pinDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 24),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 48),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -48)
        ])
    }
    
    func pinButtonSignUp() {
        NSLayoutConstraint.activate([
            buttonSignUp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            buttonSignUp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            buttonSignUp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func pinButtonLogin() {
        NSLayoutConstraint.activate([
            buttonLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            buttonLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            buttonLogin.bottomAnchor.constraint(equalTo: buttonSignUp.topAnchor, constant: -12),
            buttonLogin.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
