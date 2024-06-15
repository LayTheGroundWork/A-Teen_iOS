//
//  MainTabCoordinator+SettingsCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import ProfileFeature
import UIKit

extension MainTabCoordinator: SettingsCoordinatorDelegate {
    public func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
}
