//
//  ProfileCoordinator+SettingsCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension ProfileCoordinator: SettingsCoordinatorDelegate {
    public func didTapLogOut() {
        delegate?.didTapLogOut()
    }
}
