//
//  ProfileDetailCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import UIKit

protocol ProfileDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

final class ProfileDetailCoordinator: Coordinator {
    var navigation: Navigation
    let factory: ProfileDetailFactory
    private weak var delegate: ProfileDetailCoordinatorDelegate?
    var childCoordinators: [Coordinator]
    
    init(
        navigation: Navigation,
        factory: ProfileDetailFactory,
        delegate: ProfileDetailCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let controller = factory.makeProfileDetailViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension ProfileDetailCoordinator: ProfileDetailViewControllerCoordinator {
    func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
}

extension ProfileDetailCoordinator: ParentCoordinator { }
