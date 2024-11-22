//
//  ProfileCoordinator+MyBadgeCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension ProfileCoordinator: MyBadgeCoordinatorDelegate {
    public func didFinishMyBadgeViewController(childCoordinator: FeatureDependency.Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
