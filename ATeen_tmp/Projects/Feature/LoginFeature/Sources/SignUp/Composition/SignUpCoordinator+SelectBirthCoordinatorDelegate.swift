//
//  SignUpCoordinator+SelectBirthCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import FeatureDependency
import Foundation

extension SignUpCoordinator: SelectBirthCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, didSelectBirth: Bool) {
        if didSelectBirth {
            NotificationCenter.default.post(name: .selectBirth, object: nil, userInfo: nil)
        }
        
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
}
