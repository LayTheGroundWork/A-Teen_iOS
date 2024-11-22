//
//  ProfileCoordinator+IntroduceCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency

extension ProfileCoordinator: IntroduceCoordinatorDelegate {
    public func didFinishIntroduceViewController(childCoordinator: Coordinator, user: MyPageData) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
        profileViewControllerDelegate?.didTabBackButtonFromIntroduceViewController(user: user)
    }
}
