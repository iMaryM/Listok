//
//  ContainerViewController.swift
//  Listok
//
//  Created by Мария Манжос on 10.02.22.
//

import UIKit

class ContainerViewController: UIViewController {

    //MARK: - property
    private lazy var controlView = createControlView()
    private lazy var taskButton = createTaskButton()
    private lazy var addTaskButton = createAddTaskButton()
    private lazy var profileButton = createProfileButton()
    
    private var profileVC = ProfileViewController()
    private var taskVC = TaskViewController()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpContainerViewController()
        
        prepareUI()
    }
    
    //MARK: - actions
    @objc
    private func moveToTaskViewController() {
        profileVC.view.isHidden = true
        taskVC.view.isHidden = false
    }

    @objc
    private func moveToProfileViewController() {
        profileVC.view.isHidden = false
        taskVC.view.isHidden = true
    }
    
}

//MARK: - setup Container
private extension ContainerViewController {
    
    func setUpContainerViewController() {
        addChild(taskVC)
        addChild(profileVC)
        
        self.view.addSubview(taskVC.view)
        self.view.addSubview(profileVC.view)
        
        taskVC.view.frame = self.view.bounds
        profileVC.view.frame = self.view.bounds
        
        profileVC.view.isHidden = true
        
        taskVC.didMove(toParent: self)
        profileVC.didMove(toParent: self)
    }
    
}

//MARK: - prepare UI
private extension ContainerViewController {
    
    func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(controlView)
        controlView.addSubview(taskButton)
        controlView.addSubview(addTaskButton)
        controlView.addSubview(profileButton)
        pinControlView()
        pinTaskButton()
        pinAddTaskButton()
        pinProfileButton()
    }
    
    func createControlView() -> UIView {
        let viewControl = UIView()
        viewControl.translatesAutoresizingMaskIntoConstraints = false
        viewControl.backgroundColor = .white
        viewControl.layer.cornerRadius = 16
        viewControl.layer.shadowColor = UIColor.lightGray.cgColor
        viewControl.layer.shadowOffset = CGSize(width: 8, height: 8)
        viewControl.layer.shadowOpacity = 0.5
        viewControl.layer.shadowRadius = 8
        return viewControl
    }
    
    func createTaskButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Task"), for: .normal)
        button.addTarget(self, action: #selector(moveToTaskViewController), for: .touchUpInside)
        return button
    }
    
    func createAddTaskButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor(red: 92 / 255, green: 101 / 254, blue: 202 / 255, alpha: 1)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }
    
    func createProfileButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Folder"), for: .normal)
        button.addTarget(self, action: #selector(moveToProfileViewController), for: .touchUpInside)
        return button
    }
    
    func pinControlView() {
        NSLayoutConstraint.activate([
            controlView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            controlView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            controlView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            controlView.heightAnchor.constraint(equalToConstant: 74)
        ])
    }
    
    func pinTaskButton() {
        NSLayoutConstraint.activate([
            taskButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            taskButton.leftAnchor.constraint(equalTo: controlView.leftAnchor, constant: 24)
        ])
    }
    
    func pinAddTaskButton() {
        NSLayoutConstraint.activate([
            addTaskButton.centerXAnchor.constraint(equalTo: controlView.centerXAnchor),
            addTaskButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50),
            addTaskButton.widthAnchor.constraint(equalTo: addTaskButton.heightAnchor)
        ])
    }
    
    func pinProfileButton() {
        NSLayoutConstraint.activate([
            profileButton.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            profileButton.rightAnchor.constraint(equalTo: controlView.rightAnchor, constant: -24)
        ])
    }
}
