//
//  SearchUserCoordinator+ProfileDetailCoordinatorDelegate.swift
//  MainFeature
//
//  Created by 노주영 on 11/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension SearchUserCoordinator: ProfileDetailCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
