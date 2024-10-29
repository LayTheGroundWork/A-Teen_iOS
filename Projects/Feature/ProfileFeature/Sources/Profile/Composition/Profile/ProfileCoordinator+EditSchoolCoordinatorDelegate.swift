//
//  ProfileCoordinator+EditSchoolCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency

extension ProfileCoordinator: EditSchoolCoordinatorDelegate {
    public func didFinishEditSchoolViewController(childCoordinator: Coordinator, user: MyPageData) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
        profileViewControllerDelegate?.didTabBackButtonFromEditSchoolViewController(user: user)
    }
}
