//
//  HomeCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: HomeFactory
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: HomeFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeHomeViewController(coordinator: self)
        factory.makeItemTabBar(navigation: navigation)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerCoordinator {
    func didSelectPost(id: Int) {
        let postDetailCoordinator = factory.makePostDetailCoordinator(
            navigation: navigation,
            id: id,
            parentCoordinator: self)
        addChildCoordinatorStart(postDetailCoordinator)
    }
}

extension HomeCoordinator: ParentCoordinator { }
