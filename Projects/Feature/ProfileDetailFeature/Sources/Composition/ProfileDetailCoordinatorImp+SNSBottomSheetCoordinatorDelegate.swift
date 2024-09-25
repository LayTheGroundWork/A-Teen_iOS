//
//  ProfileDetailCoordinatorImp+SNSBottomSheetCoordinatorDelegate.swift
//  ProfileDetailFeature
//
//  Created by 최동호 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension ProfileDetailCoordinatorImp: SNSBottomSheetCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        clearAllViewControllers(childCoordinator)
        removeChildCoordinator(childCoordinator)

        guard let childCoordinator = childCoordinator as? ParentCoordinator else { return }
        childCoordinator.clearAllChildsCoordinator()
    }
}
