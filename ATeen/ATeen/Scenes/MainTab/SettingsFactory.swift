//
//  SettingsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol SettingsFactory {
    func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController
    func makeAccountViewController() -> UIViewController
    func makeThemeViewController() -> UIViewController
    func makeUserConfigurationCoordinator(delegate: UserConfigurationCoordinatorDelegate) -> Coordinator
}

struct SettingsFactoryImp: SettingsFactory {
    let appContainer: AppContainer?
    
    func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(auth: appContainer?.auth)
        let controller = SettingsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.title = "Settings ⚙️"
        return controller
    }
    
    func makeAccountViewController() -> UIViewController {
        let controller = ExampleViewController()
        controller.title = "Account"
        return controller
    }
    
    func makeThemeViewController() -> UIViewController {
        let controller = ExampleViewController()
        controller.title = "Theme"
        return controller
    }
    
    func makeUserConfigurationCoordinator(delegate: UserConfigurationCoordinatorDelegate) -> Coordinator {
        let factory = UserConfigurationFactory()
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        return UserConfigurationCoordinator(navigation: navigation, factory: factory, delegate: delegate)
    }
}
