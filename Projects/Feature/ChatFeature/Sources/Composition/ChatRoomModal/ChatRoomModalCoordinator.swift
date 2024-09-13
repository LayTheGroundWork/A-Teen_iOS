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
    func didFinishChatRoomModal(childCoordinator: Coordinator)
    func didTappedReportButton(childCoordinator: Coordinator)
    func didTappedLeaveButton(childCoordinator: Coordinator)
}

public final class ChatRoomModalCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: ChatRoomModalFactory
    public var childCoordinators: [Coordinator] = []
    public var factoryProvider: FactoryProvider
    public var coordinatorProvider: CoordinatorProvider

    weak var delegate: ChatRoomModalCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: ChatRoomModalFactory,
        delegate: ChatRoomModalCoordinatorDelegate,
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.factoryProvider = factoryProvider
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeChatRoomModalViewController(
            coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension ChatRoomModalCoordinator: ParentCoordinator { }


