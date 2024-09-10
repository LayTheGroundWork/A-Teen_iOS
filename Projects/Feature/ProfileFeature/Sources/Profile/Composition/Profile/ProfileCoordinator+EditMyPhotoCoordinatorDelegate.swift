//
//  ProfileCoordinator+EditMyPhotoCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension ProfileCoordinator: EditMyPhotoCoordinatorDelegate {
    public func didFinishEditMyPhoto(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
