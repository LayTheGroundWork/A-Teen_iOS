//
//  ChatRoomModalCoordinator+ChatRoomModalViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension ChatRoomModalCoordinator: ChatRoomModalViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinishModal(childCoordinator: self)
    }
}

