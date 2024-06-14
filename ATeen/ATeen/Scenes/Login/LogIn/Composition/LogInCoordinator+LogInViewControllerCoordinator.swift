//
//  LogInCoordinator+LogInViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

extension LogInCoordinator: LogInViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishLogin(childCoordinator: self)
    }
    
    func didSelectSignUpButton() {
        let coordinator = factory.makePhoneNumberCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
