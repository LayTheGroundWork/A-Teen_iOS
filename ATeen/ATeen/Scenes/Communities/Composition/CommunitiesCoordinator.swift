//
//  CommunitiesCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

final class CommunitiesCoordinator: Coordinator {
    var navigation: UINavigationController
    private var factory: CommunitiesFactory
    
    init(
        navigation: UINavigationController,
        factory: CommunitiesFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeMyCommunitiesViewController()
        factory.makeItemTabBar(navigation: navigation)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
