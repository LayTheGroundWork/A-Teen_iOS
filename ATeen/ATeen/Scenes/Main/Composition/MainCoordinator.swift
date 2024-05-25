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
    weak var delegate: MainTabHiddenDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: MainFactory,
        delegate: MainTabHiddenDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeMainViewController(coordinator: self)
        
        navigation.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: ParentCoordinator { }