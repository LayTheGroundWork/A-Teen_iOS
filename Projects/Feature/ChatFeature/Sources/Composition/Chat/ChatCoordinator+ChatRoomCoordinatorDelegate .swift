//
//  ChatCoordinator+ChatRoomCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatCoordinator: ChatRoomCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
