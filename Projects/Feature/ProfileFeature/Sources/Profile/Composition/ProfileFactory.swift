//
//  ProfileFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import FeatureDependency
import UIKit

public protocol ProfileFactory {
    func makeProfileViewController(coordinator: ProfileViewControllerCoordinator) -> UIViewController
    func makeSettingCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: SettingsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator
}

public struct ProfileFactoryImp: ProfileFactory {
    
    public init() { }
    
    public func makeProfileViewController(coordinator: ProfileViewControllerCoordinator) -> UIViewController {
        let controller = ProfileViewController(coordinator: coordinator)
        controller.navigationItem.title = "Profile"
        return controller
    }
    
    public func makeSettingCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: SettingsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = SettingsFactoryImp()
        let coordinator = SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
}
