//
//  MainCoordinator+SearchUserCoordinatorDelegate.swift
//  MainFeature
//
//  Created by 노주영 on 11/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension MainCoordinator: SearchUserCoordinatorDelegate {
    public func didFinishSearchUser(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func configTabbarState(view: MainViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
