//
//  ChatRoomCoordinator+OperatingPolicyModalCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomCoordinator: OperatingPolicyCoordinatorDelegate {
    public func didFinishWebViewModal(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
    }
}
