//
//  ChatRoomCoordinator+ReportDialogCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomCoordinator: ReportDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismiss(animated: false)
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func didReport() {
        // TODO: - Report 하는 코드 필요
        self.didFinish(childCoordinator: self)
    }
}
