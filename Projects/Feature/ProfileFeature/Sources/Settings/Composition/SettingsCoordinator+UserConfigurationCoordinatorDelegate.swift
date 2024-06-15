//
//  SettingsCoordinator+UserConfigurationCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import FeatureDependency

extension SettingsCoordinator: UserConfigurationCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
    }
}
