//
//  MainTabCoordinator+SettingsCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

extension MainTabCoordinator: SettingsCoordinatorDelegate {
    func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
}
