//
//  ProfileDetailCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import FeatureDependency
import UIKit

public protocol ProfileDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class ProfileDetailCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: ProfileDetailFactory
    private weak var delegate: ProfileDetailCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
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
    
    public func start() {
        let controller = factory.makeProfileDetailViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension ProfileDetailCoordinator: ProfileDetailViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
}

extension ProfileDetailCoordinator: ParentCoordinator { }
