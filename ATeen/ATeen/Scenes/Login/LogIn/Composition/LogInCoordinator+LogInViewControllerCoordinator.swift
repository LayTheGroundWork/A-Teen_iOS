//
//  LogInCoordinator+LogInViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

extension LogInCoordinator: LogInViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishLogin()
    }
    
    func didSelectSignUpButton() {
        let coordinator = factory.makeSignUpCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
