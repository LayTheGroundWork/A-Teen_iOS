//
//  IntroduceCoordinator+IntroduceViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension IntroduceCoordinator: IntroduceViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishIntroduceViewController(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
