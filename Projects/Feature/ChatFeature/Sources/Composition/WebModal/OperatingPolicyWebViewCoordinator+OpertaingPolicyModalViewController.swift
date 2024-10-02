//
//  OperatingPolicyWebViewCoordinator+OpertaingPolicyModalViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 9/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

extension OperatingPolicyWebViewCoordinator: OpertaingPolicyModalViewControllerCoordinator {
    public func didFinish() {
        self.delegate?.didFinishWebViewModal(childCoordinator: self)
    }
}
