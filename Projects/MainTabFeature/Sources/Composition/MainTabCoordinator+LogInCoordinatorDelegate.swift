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
        childCoordinator.navigation.dismissNavigation = nil
        clearAllViewControllers(childCoordinator)
        removeChildCoordinator(childCoordinator)
        
        guard let childCoordinator = childCoordinator as? ParentCoordinator else { return }
        childCoordinator.clearAllChildsCoordinator()
        
        //clearAllChildsCoordinator()
        //delegate?.didFinish()
    }
}
