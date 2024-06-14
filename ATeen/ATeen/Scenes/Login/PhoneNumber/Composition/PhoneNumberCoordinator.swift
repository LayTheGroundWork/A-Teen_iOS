//
//  PhoneNumberCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import Foundation

protocol PhoneNumberCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func navigateToMainViewController()
}

final class PhoneNumberCoordinator: Coordinator {
    var navigation: Navigation
    var factory: PhoneNumberFactory
    var childCoordinators: [Coordinator]
    weak var delegate: PhoneNumberCoordinatorDelegate?
    
    init(
        navigation: Navigation,
        factory: PhoneNumberFactory,
        childCoordinators: [Coordinator],
        delegate: PhoneNumberCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makePhoneNumberViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension PhoneNumberCoordinator: ParentCoordinator { }
