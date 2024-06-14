//
//  SelectBirthCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import Foundation

protocol SelectBirthCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator, didSelectBirth: Bool)
}

final class SelectBirthCoordinator: Coordinator {
    var navigation: Navigation
    let factory: SelectBirthFactory
    weak var delegate: SelectBirthCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: SelectBirthFactory,
        delegate: SelectBirthCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeSelectBirthViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension SelectBirthCoordinator: ParentCoordinator { }
