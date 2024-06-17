//
//  MainTabCoordinator+LogInCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/27/24.
//

import FeatureDependency
import LoginFeature
import UIKit

extension MainTabCoordinator: LogInCoordinatorDelegate {
    public func didFinishLogin(childCoordinator: Coordinator) {
        //
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
        //
        clearAllChildsCoordinator()
        delegate?.didFinish()
    }
}
