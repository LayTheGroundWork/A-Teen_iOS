//
//  PhoneNumberCoordinator+TermsOfUseCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency

extension PhoneNumberCoordinator: TermsOfUseCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
