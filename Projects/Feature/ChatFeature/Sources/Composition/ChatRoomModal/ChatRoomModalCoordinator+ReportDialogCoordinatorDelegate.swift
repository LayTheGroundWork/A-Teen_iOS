//
//  ChatRoomModalCoordinator+ReportDialogCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomModalCoordinator: ReportDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: false)
        delegate?.didFinishChatRoomModal(childCoordinator: self)
    }
    
    public func didReport() {
        self.didFinish(childCoordinator: self)
    }
}
