//
//  ProfileFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import FeatureDependency
import SettingsFeature
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
    let appContainer: AppContainer?
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
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
        let factory = SettingsFactoryImp(appContainer: appContainer)
        let coordinator = SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
}
