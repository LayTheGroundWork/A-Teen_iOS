//
//  SettingsCoordinator+UserConfigurationCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

extension SettingsCoordinator: UserConfigurationCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
    }
}
