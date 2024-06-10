//
//  LogInCoordinator+PhoneNumberCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

extension LogInCoordinator: PhoneNumberCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    func navigateToMainViewController() {
        // login coordinator 지우기
        delegate?.didFinishLogin(childCoordinator: self)
    }
}
