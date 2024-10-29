//
//  ProfileCoordinator+EditUserNameCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency

extension ProfileCoordinator: EditUserNameCoordinatorDelegate {
    public func didFinishUserNameViewController(childCoordinator: Coordinator, user: MyPageData) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
        profileViewControllerDelegate?.didTabBackButtonFromEditUserNameViewController(user: user)
    }
}
