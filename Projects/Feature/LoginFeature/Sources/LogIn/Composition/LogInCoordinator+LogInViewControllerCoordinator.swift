//
//  LogInCoordinator+LogInViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

import FeatureDependency

extension LogInCoordinator: LogInViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinishLogin(childCoordinator: self)
    }
    
    public func didSelectSignButton() {
        let coordinator = factory.makePhoneNumberCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
