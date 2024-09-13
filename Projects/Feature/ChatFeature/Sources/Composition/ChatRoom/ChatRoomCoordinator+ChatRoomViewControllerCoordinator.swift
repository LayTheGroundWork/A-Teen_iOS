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
    
    public func didTapBackButton() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didTapOptionButton() {
        let chatRoomModalCoordinator = factory.makeChatRoomModalCoordinator(
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators,
            factoryProvider: factoryProvider,
            coordinatorProvider: coordinatorProvider)
        
        addChildCoordinatorStart(chatRoomModalCoordinator)
        
        navigation.present(
            chatRoomModalCoordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didTapOperatingPolicyButton() {
        let operatingPolicyCoordinator = factory.makeOperatingPolicyWebViewCoordinator(
            parentCoordinator: self,
            delegate: self)
        
        addChildCoordinatorStart(operatingPolicyCoordinator)
        
        navigation.present(
            operatingPolicyCoordinator.navigation.rootViewController,
            animated: true)
    }
}
