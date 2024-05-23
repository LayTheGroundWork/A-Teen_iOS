//
//  MainFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol MainFactory {
    func makeMainViewController() -> UIViewController
}

struct MainFactoryImp: MainFactory {
    func makeMainViewController() -> UIViewController {
        let controller = MainViewController()
        controller.navigationItem.title = "Main"
        return controller
    }
}
