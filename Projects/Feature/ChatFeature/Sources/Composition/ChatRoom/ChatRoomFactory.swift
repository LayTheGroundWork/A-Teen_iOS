//
//  ChatRoomFactory.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import FeatureDependency

public protocol ChatRoomFactory {
    func makeChatRoomViewController(coordinator: ChatRoomViewControllerCoordinator) -> UIViewController
    func makeChatRoomModalCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: ChatRoomModalCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> ChatRoomModalCoordinator
    func makeOperatingPolicyWebViewCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: OperatingPolicyModalCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> OperatingPolicyWebViewCoordinator
}

public struct ChatRoomFactoryImp: ChatRoomFactory {
    var userID: ChatModel
    
    public init (userID: ChatModel) {
        self.userID = userID
    }
    
    public func makeChatRoomViewController(coordinator: ChatRoomViewControllerCoordinator) -> UIViewController {
        let controller = ChatRoomViewController(partnerName: userID.name, coordinator: coordinator)
        return controller
    }
    
    public func makeChatRoomModalCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: ChatRoomModalCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> ChatRoomModalCoordinator {
        let factory = ChatRoomModalFactoryImp()
        let coordinator = ChatRoomModalCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
        return coordinator
    }
    
    public func makeOperatingPolicyWebViewCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: OperatingPolicyModalCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> OperatingPolicyWebViewCoordinator {
        let factory = OperatingPolicyWebViewFactoryImp()
        let coordinator = OperatingPolicyWebViewCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
        return coordinator
    }
}
