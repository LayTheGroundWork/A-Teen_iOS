//
//  SignUpCoordinator+AlbumCoordinatorDelegate.swift
//  LoginFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import Foundation

extension SignUpCoordinator: AlbumCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
    }
}
