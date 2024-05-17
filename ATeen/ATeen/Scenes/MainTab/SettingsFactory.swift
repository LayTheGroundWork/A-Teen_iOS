//
//  SettingsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

struct SettingsFactory: ItemTabFactory {
    let appContainer: AppContainer?
    
    func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(auth: appContainer?.auth)
        let controller = SettingsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.title = "Settings ⚙️"
        return controller
    }
    
    func makeTabBarItem(navigation: UINavigationController) {
        makeItemTabBar(
            navigation: navigation,
            title: "Settings",
            image: "gearshape.2",
            selectedImage: "gearshape.2.fill"
        )
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
    
}
