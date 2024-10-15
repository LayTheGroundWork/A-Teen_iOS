//
//  EditSchoolCoordinator+EditSchoolViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain

extension EditSchoolCoordinator: EditSchoolViewControllerCoordinator {
    public func didTabBackButton(user: MyPageData) {
        delegate?.didFinishEditSchoolViewController(childCoordinator: self, user: user)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
