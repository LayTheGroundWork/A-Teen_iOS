//
//  ChatCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public enum ChatFeatureViewNames {
    case main
    case chatRoom
}

public protocol ChatConfigTabbarStateDelegate: AnyObject {
    func configTabbarState(view: ChatFeatureViewNames)
}

public protocol ChatCoordinatorDelegate: ChatConfigTabbarStateDelegate { }

public final class ChatCoordinator: Coordinator, MainChatViewControllerCoordinator {
    
    
    public var navigation: Navigation
    public var factory: ChatFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: ChatCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: ChatFactory,
        delegate: ChatCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeMainChatViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
    
    public func navigateToChatRoom(chatRoom: ChatModel) {
        let chatRoomVC = factory.makeChatRoomViewController()
        if let chatRoomVC = chatRoomVC as? ChatRoomViewController {
            chatRoomVC.partnerName = chatRoom.name
            chatRoomVC.coordinator = self
        }
        navigation.pushViewController(chatRoomVC, animated: true)
    }
}
