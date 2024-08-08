//
//  ChatRoomCoordinator+ChatRoomModalCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomCoordinator: ChatRoomModalCoordinatorDelegate {
    public func didFinishModal(childCoordinator: FeatureDependency.Coordinator) {
        removeChildCoordinator(childCoordinator)
    }
}
