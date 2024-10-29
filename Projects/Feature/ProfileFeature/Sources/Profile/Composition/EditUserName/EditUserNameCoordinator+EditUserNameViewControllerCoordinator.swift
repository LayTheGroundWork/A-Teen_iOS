//
//  EditUserNameCoordinator+EditUserNameViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain

extension EditUserNameCoordinator: EditUserNameViewControllerCoordinator {
    public func didTabBackButton(user: MyPageData) {
        delegate?.didFinishUserNameViewController(childCoordinator: self, user: user)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
