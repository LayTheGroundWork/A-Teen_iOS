//
//  TermsOfUseCoordinator+SignUpCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency

extension TermsOfUseCoordinator: SignUpCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
