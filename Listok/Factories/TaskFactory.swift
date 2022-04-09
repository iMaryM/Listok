//
//  TaskFactory.swift
//  Listok
//
//  Created by Мария Манжос on 4.04.22.
//

import Foundation

class TaskFactory {
    func create() -> TaskViewController {
        let router = TaskRouter()
        let presenter = TaskPresenter(router: router)
        let vc = TaskViewController()
        presenter.vc = vc
        vc.setPresenter(presenter: presenter)
        return vc
    }
}
