//
//  SignUpCoordinator+CelebrateCoordinatorDelegate.swift
//  LoginFeature
//
//  Created by 최동호 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension SignUpCoordinator: CelebrateCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
