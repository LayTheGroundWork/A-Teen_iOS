//
//  SettingsCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didTapLogOut()
}

final class SettingsCoordinator: Coordinator {
    var navigation: Navigation
    var factory: SettingsFactory
    weak var delegate: SettingsCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: SettingsFactory,
        delegate: SettingsCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeSettingsCotroller(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
        factory.makeTabBarItem(navigation: navigation)
    }
}

extension SettingsCoordinator: ParentCoordinator { }


