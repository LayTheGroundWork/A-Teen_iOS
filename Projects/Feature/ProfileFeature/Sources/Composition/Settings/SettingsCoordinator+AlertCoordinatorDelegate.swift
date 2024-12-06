//
//  SettingsCoordinator+AlertCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 11/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension SettingsCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        switch selectIndex {
        case 0:
            childCoordinator.navigation.dismissNavigation = nil
            removeChildCoordinator(childCoordinator)
            navigation.dismiss(animated: false)
        case 1:
            childCoordinator.navigation.dismissNavigation = nil
            removeChildCoordinator(childCoordinator)
            navigation.dismiss(animated: false)
            
            guard let factory = factory as? SettingsFactoryImp else { return }
            
            factory.viewModel.performUserAction()
            delegate?.didTapLogOut(childCoordinator: self)
        default:
            break
        }
    }
}
