//
//  LogInCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol LogInCoordinatorDelegate: AnyObject {
    func didFinishLogin(childCoordinator: Coordinator)
}

final class LogInCoordinator: Coordinator {
    var navigation: Navigation
    var factory: LogInFactory
    weak var delegate: LogInCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: LogInFactory,
        delegate: LogInCoordinatorDelegate? = nil
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    func start() {
        let controller = factory.makeLoginViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension LogInCoordinator: ParentCoordinator { }
