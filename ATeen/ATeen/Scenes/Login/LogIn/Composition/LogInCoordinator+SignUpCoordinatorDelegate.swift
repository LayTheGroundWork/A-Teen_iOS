//
//  LogInCoordinator+SignUpCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/30/24.
//

extension LogInCoordinator: SignUpCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
