//
//  ChatRoomCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol ChatRoomCoordinatorDelegate: ChatConfigTabbarStateDelegate {
    func didFinish(childCoordinator: Coordinator)
}

public final class ChatRoomCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: ChatRoomFactory
    public var childCoordinators: [Coordinator]
    weak var delegate: ChatRoomCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: ChatRoomFactory,
        childCoordinator: [Coordinator],
        delegate: ChatRoomCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinator
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeChatRoomViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
