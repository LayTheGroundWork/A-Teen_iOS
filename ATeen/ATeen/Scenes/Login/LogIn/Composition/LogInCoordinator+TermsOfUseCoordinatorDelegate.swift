//
//  LogInCoordinator+TermsOfUseCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/30/24.
//

import Foundation

extension LogInCoordinator: TermsOfUseCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.rootViewController.popViewController(animated: true)
    }
}
