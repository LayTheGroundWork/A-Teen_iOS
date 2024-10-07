//
//  ChatRoomCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol ChatRoomCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func configTabbarState(view: ChatFeatureViewNames)
}

public final class ChatRoomCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: ChatRoomFactory
    public var childCoordinators: [Coordinator]
    public var factoryProvider: FactoryProvider
    public var coordinatorProvider: CoordinatorProvider
    weak var delegate: ChatRoomCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: ChatRoomFactory,
        childCoordinator: [Coordinator],
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider,
        delegate: ChatRoomCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinator
        self.factoryProvider = factoryProvider
        self.coordinatorProvider = coordinatorProvider
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeChatRoomViewController(
            coordinator: self,
            factoryProvider: factoryProvider,
            coordinatorProvider: coordinatorProvider)
        navigation.pushViewController(controller, animated: true)
    }
}

extension ChatRoomCoordinator: ParentCoordinator { }


