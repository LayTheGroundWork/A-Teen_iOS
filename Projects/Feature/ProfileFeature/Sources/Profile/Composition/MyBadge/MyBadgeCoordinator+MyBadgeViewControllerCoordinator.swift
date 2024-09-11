//
//  MyBadgeCoordinator+MyBadgeViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common

extension MyBadgeCoordinator: MyBadgeViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishMyBadgeViewController(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: .another)
    }
    
    public func didSelectCell(badge: BadgeType) {
        print(badge)
    }
}
