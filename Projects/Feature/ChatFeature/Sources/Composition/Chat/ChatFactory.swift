//
//  ChatFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import FeatureDependency
import UIKit

public protocol ChatFactory {
    func makeChatViewController(coordinator: ChatViewControllerCoordinator) -> UIViewController
    func makeChatRoomCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: ChatRoomCoordinatorDelegate,
        childCoordinators: [Coordinator],
        userID: ChatModel
    ) -> Coordinator
}

public struct ChatFactoryImp: ChatFactory {
    public init () { }
    
    public func makeChatViewController(coordinator: ChatViewControllerCoordinator) -> UIViewController {
        let viewModel = ChatViewModel()
        let controller = ChatViewController(coordinator: coordinator, viewModel: viewModel)
        return controller
    }
    
    public func makeChatRoomCoordinator(
        navigation: FeatureDependency.Navigation,
        parentCoordinator:  FeatureDependency.ParentCoordinator,
        delegate: ChatRoomCoordinatorDelegate,
        childCoordinators: [FeatureDependency.Coordinator],
        userID: ChatModel
    ) -> FeatureDependency.Coordinator {
        let factory = ChatRoomFactoryImp(userID: userID)
        let coordinator = ChatRoomCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinator: childCoordinators,
            delegate: delegate
        )
        return coordinator
    }
}
