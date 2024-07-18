//
//  ProfileCoordinator+QuestionsCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension ProfileCoordinator: QuestionsCoordinatorDelegate {
    public func didFinishQuestionsViewController(childCoordinator: FeatureDependency.Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
