//
//  ChatRoomModalCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol ChatRoomModalCoordinatorDelegate: AnyObject {
    func didFinishModal(childCoordinator: Coordinator)
}

public final class ChatRoomModalCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: ChatRoomModalFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: ChatRoomModalCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: ChatRoomModalFactory,
        delegate: ChatRoomModalCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeChatRoomModalViewController(coordinator: self)
        navigation.present(controller, animated: true, completion: nil)
    }
}




