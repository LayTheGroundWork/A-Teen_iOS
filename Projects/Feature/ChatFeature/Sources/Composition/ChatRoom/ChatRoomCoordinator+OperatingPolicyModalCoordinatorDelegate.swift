//
//  ChatRoomCoordinator+OperatingPolicyModalCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomCoordinator: OperatingPolicyModalCoordinatorDelegate {
    public func didFinishWebViewModal(childCoordinator: FeatureDependency.Coordinator) {
        removeChildCoordinator(childCoordinator)
    }
}
