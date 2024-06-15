//
//  ChatCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public final class ChatCoordinator: Coordinator {
    public var navigation: Navigation
    private var factory: ChatFactory
    
    public init(
        navigation: Navigation,
        factory: ChatFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    public func start() {
        let controller = factory.makeChatViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
