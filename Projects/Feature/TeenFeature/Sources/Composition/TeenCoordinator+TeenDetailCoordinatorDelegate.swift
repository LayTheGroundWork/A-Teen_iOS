//
//  TeenCoordinator+TeenDetailCoordinatorDelegate.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension TeenCoordinator: TeenDetailCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func didSelectChattingButton() {
        delegate?.didSelectChattingButton()
    }
}
