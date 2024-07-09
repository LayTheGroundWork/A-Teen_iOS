//
//  SettingsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import FeatureDependency
import UIKit

public protocol SettingsFactory {
    func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController
    func makeAccountViewController() -> UIViewController
    func makeThemeViewController() -> UIViewController
    func makeUserConfigurationCoordinator(delegate: UserConfigurationCoordinatorDelegate) -> Coordinator
}

public struct SettingsFactoryImp: SettingsFactory {
    
    public init() { }
    
    public func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel()
        let controller = SettingsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.title = "Settings ⚙️"
        return controller
    }
    
    public func makeAccountViewController() -> UIViewController {
        let controller = ExampleViewController()
        controller.title = "Account"
        return controller
    }
    
    public func makeThemeViewController() -> UIViewController {
        let controller = ExampleViewController()
        controller.title = "Theme"
        return controller
    }
    
    public func makeUserConfigurationCoordinator(delegate: UserConfigurationCoordinatorDelegate) -> Coordinator {
        let factory = UserConfigurationFactory()
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        return UserConfigurationCoordinator(navigation: navigation, factory: factory, delegate: delegate)
    }
}
