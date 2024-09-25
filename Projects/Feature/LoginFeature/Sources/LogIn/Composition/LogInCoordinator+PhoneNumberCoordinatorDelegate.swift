//
//  LogInCoordinator+PhoneNumberCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency

extension LogInCoordinator: PhoneNumberCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func navigateToMainViewController() {
        // login coordinator 지우기
        delegate?.didFinishLogin(childCoordinator: self)
        navigation.dismiss(animated: true)
    }
}
