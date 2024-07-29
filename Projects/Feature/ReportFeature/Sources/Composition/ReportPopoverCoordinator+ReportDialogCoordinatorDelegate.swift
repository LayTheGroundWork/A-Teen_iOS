//
//  ReportPopoverCoordinator+ReportDialogCoordinatorDelegate.swift
//  ReportFeature
//
//  Created by 최동호 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension ReportPopoverCoordinator: ReportDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: false)
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didReport() {
        delegate?.didFinish(childCoordinator: self)
        delegate?.didReport()
    }
}
