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
    func makeSearchUserCoordinator(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        delegate: SearchUserCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator
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
    
    public func makeSearchUserCoordinator(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        delegate: SearchUserCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = SearchUserFactoryImp()
        return SearchUserCoordinator(
            navigation: navigation,
            coordinatorProvider: coordinatorProvider,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
    }
}
