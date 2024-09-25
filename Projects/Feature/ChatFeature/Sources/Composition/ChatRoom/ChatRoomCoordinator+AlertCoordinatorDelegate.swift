//
//  ChatRoomCoordinator+.swift
//  ChatFeature
//
//  Created by 김명현 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatRoomCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        
        switch selectIndex {
        case 1:
            delegate?.didFinish(childCoordinator: self)
        default:
            break
        }
    }
}
