//
//  IntroduceCoordinator+IntroduceViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency

extension IntroduceCoordinator: IntroduceViewControllerCoordinator {
    public func didTabBackButton(user: MyPageData) {
        delegate?.didFinishIntroduceViewController(childCoordinator: self, user: user)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
