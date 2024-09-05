//
//  ChatRoomCoordinator+ChatRoomViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import FeatureDependency
import SafariServices

extension ChatRoomCoordinator: ChatRoomViewControllerCoordinator {
    public func configTabbarState(view: ChatFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
    
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func presentChatRoomModal() {
        let chatRoomModalCoordinator = factory.makeChatRoomModalCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        
        addChildCoordinatorStart(chatRoomModalCoordinator)
    }
    
    public func presentOperatingPolicyWebView() {
        let operatingPolicyCoordinator = factory.makeOperatingPolicyWebViewCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        
        addChildCoordinatorStart(operatingPolicyCoordinator)
    }
}
