//
//  ChatRoomCoordinator+ChatRoomViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension ChatRoomCoordinator: ChatRoomViewControllerCoordinator {
    public func configTabbarState(view: ChatFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
    
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
