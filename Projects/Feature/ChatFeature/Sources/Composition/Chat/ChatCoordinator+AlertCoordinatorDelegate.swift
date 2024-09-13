//
//  ChatCoordinator+AlertCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency

extension ChatCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        removeChildCoordinator(childCoordinator)
        
        switch selectIndex {
        case 0:
            navigation.dismiss(animated: false)
        case 1:
            if let chatViewController = navigation.viewControllers.last as? ChatViewController,
               let indexPath = chatViewController.selectIndexPath {
                chatViewController.leaveChatRoom(at: indexPath)
            }
            navigation.dismiss(animated: false)  
        default:
            break
        }
    }
}

