//
//  ContainerFactory.swift
//  Listok
//
//  Created by Мария Манжос on 17.02.22.
//

import Foundation
import UIKit

protocol ContainerFactoryProtocol {
    func create(firstViewController: UIViewController, secondViewController: UIViewController) -> ContainerViewController
}

class ContainerFactory: ContainerFactoryProtocol {
    func create(firstViewController: UIViewController, secondViewController: UIViewController) -> ContainerViewController {
        let viewController = ContainerViewController()
        viewController.setViewController(firstViewController: firstViewController, secondViewController: secondViewController)
        return viewController
    }
}
