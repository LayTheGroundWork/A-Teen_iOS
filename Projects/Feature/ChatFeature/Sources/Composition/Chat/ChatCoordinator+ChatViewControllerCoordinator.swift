//
//  ChatCoordinator+ChatViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension ChatCoordinator: ChatViewControllerCoordinator {
    public func didTapCell(userID: ChatModel) {
        let coordinator = factory.makeChatRoomCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators,
            userID: userID)
        
        addChildCoordinatorStart(coordinator)
    }
}
