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
    func makeLinksDialogCoordinator(
        delegate: LinksDialogCoordinatorDelegate
    ) -> Coordinator
}

public struct ProfileFactoryImp: ProfileFactory {
    let appContainer: AppContainer?
    let viewModel = ProfileViewModel()
    
    public init() { }
    
    public func makeProfileViewController(
        coordinator: ProfileViewControllerCoordinator
    ) -> UIViewController {
        let controller = ProfileViewController(viewModel: viewModel, coordinator: coordinator)
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
    
    public func makeLinksDialogCoordinator(delegate: LinksDialogCoordinatorDelegate) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = LinksDialogFactoryImp(viewModel: viewModel)

        let coordinator = LinksDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
        return coordinator
    }
}
