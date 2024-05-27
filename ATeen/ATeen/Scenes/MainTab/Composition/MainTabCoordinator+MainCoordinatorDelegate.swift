//
//  MainTabCoordinator+MainCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/27/24.
//

import UIKit

extension MainTabCoordinator: MainCoordinatorDelegate {
    func didSelectChattingButton() {
        let loginCoordinator = factory.makeLoginCoordinator(delegate: self)
        
        addChildCoordinatorStart(loginCoordinator)
        
        navigation.present(
            loginCoordinator.navigation.rootViewController,
            animated: true)
        
        loginCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(loginCoordinator)
        }
    }
}
