//
//  ChatCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

final class ChatCoordinator: Coordinator {
    var navigation: Navigation
    private var factory: ChatFactory
    
    init(
        navigation: Navigation,
        factory: ChatFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeChatViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
