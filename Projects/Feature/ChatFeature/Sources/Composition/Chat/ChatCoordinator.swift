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

public final class ChatCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: ChatFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: ChatConfigTabbarStateDelegate?
    
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
        let controller = factory.makeChatViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension ChatCoordinator: ParentCoordinator { }
