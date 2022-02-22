//
//  ProfileRouter.swift
//  Listok
//
//  Created by Мария Манжос on 16.02.22.
//

import Foundation
import UIKit

enum ProfileSegue {
    case goToLogin
}

protocol ProfileRouterProtocol {
    func perform(segue: ProfileSegue, viewController: UIViewController)
}

class ProfileRouter: ProfileRouterProtocol {
    func perform(segue: ProfileSegue, viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
