//
//  MainCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigation: Navigation
    let factory: MainFactory
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: MainFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeMainViewController(coordinator: self)
        
        navigation.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: ParentCoordinator { }
