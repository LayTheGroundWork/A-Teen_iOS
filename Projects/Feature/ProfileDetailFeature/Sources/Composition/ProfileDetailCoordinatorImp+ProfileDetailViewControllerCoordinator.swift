//
//  ProfileDetailCoordinatorImp+ProfileDetailViewControllerCoordinator.swift
//  ProfileDetailFeature
//
//  Created by 최동호 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension ProfileDetailCoordinatorImp: ProfileDetailViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
}
