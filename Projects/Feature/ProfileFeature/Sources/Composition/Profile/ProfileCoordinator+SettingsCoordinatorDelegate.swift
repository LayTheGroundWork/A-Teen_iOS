//
//  ProfileCoordinator+SettingsCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension ProfileCoordinator: SettingsCoordinatorDelegate {
    public func didFinishSettingsViewController(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func didTapLogOut(childCoordinator: Coordinator) {
        didFinishSettingsViewController(childCoordinator: childCoordinator)
        delegate?.didTapLogOut()
    }
}
