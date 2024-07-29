//
//  MainFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import Common
import FeatureDependency
import UIKit

public protocol MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController
}

public struct MainFactoryImp: MainFactory {
    let viewModel = MainViewModel()
    
    public init() { }
    
    public func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {

        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
