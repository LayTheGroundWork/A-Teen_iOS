//
//  MyBadgeCoordinator+MyBadgeDetailCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension MyBadgeCoordinator: MyBadgeDetailCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
}
