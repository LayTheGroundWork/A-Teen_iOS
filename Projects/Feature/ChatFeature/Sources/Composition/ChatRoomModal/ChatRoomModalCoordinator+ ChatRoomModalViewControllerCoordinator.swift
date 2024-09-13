//
//  ChatRoomModalCoordinator+ChatRoomModalViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

extension ChatRoomModalCoordinator: ChatRoomModalViewControllerCoordinator {
    public func didTapLeaveButton() {
        delegate?.didTappedLeaveButton(childCoordinator: self)
    }
    
    public func didTapReportButton() {
        let reportDialogCoordinator = coordinatorProvider.makeReportDialogCoordinator(navigation: navigation, delegate: self, childCoordinator: childCoordinators, dialogType: .chat)
        
        addChildCoordinatorStart(reportDialogCoordinator)
    }
    
    public func didFinish() {
        self.delegate?.didFinishChatRoomModal(childCoordinator: self)
    }
}
