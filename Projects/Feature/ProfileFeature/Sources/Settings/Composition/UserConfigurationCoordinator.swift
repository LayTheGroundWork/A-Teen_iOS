//
//  UserConfigurationCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import FeatureDependency

public protocol UserConfigurationCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class UserConfigurationCoordinator: Coordinator {
    public var navigation: Navigation
    private let factory: UserConfigurationFactory
    private weak var delegate: UserConfigurationCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: UserConfigurationFactory,
        delegate: UserConfigurationCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeUserConfigurationViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension UserConfigurationCoordinator: UserConfigurationViewControllerCoordinator { 
    public func didSelectAvatarButton() {
        navigation.pushViewController(factory.makeAvatarViewController(), animated: true)
    }
    
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
}
