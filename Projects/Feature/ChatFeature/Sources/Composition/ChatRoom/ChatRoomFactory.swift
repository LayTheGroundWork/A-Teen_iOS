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
    func makeChatRoomViewController(coordinator: ChatRoomViewControllerCoordinator, factoryProvider: FactoryProvider, coordinatorProvider: CoordinatorProvider) -> UIViewController
    
    func makeChatRoomModalCoordinator(
        parentCoordinator: ParentCoordinator,
        delegate: ChatRoomModalCoordinatorDelegate,
        childCoordinators: [Coordinator],
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider
    ) -> ChatRoomModalCoordinator
    
    func makeOperatingPolicyWebViewCoordinator(
        parentCoordinator: ParentCoordinator,
        delegate: OperatingPolicyModalCoordinatorDelegate
    ) -> OperatingPolicyWebViewCoordinator
}

public struct ChatRoomFactoryImp: ChatRoomFactory {
    private var userID: ChatModel
    private var factoryProvider: FactoryProvider
    private var coordinatorProvider: CoordinatorProvider
    
    public init (
        userID: ChatModel,
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.userID = userID
        self.factoryProvider = factoryProvider
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func makeChatRoomViewController(
        coordinator: ChatRoomViewControllerCoordinator,
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider) -> UIViewController {
            let controller = ChatRoomViewController(partnerName: userID.name, coordinator: coordinator)
            return controller
        }
    
    public func makeChatRoomModalCoordinator(
        parentCoordinator: ParentCoordinator,
        delegate: ChatRoomModalCoordinatorDelegate,
        childCoordinators: [Coordinator],
        factoryProvider: FactoryProvider,
        coordinatorProvider: CoordinatorProvider
    ) -> ChatRoomModalCoordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = ChatRoomModalFactoryImp()
        let coordinator = ChatRoomModalCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            factoryProvider: factoryProvider,
            coordinatorProvider: coordinatorProvider
        )
        return coordinator
    }
    
    public func makeOperatingPolicyWebViewCoordinator(
        parentCoordinator: ParentCoordinator,
        delegate: OperatingPolicyModalCoordinatorDelegate
    ) -> OperatingPolicyWebViewCoordinator {
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = OperatingPolicyWebViewFactoryImp()
        let coordinator = OperatingPolicyWebViewCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
        return coordinator
    }
}
