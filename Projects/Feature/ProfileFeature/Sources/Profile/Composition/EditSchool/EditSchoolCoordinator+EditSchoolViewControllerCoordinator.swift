//
//  EditSchoolCoordinator+EditSchoolViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension EditSchoolCoordinator: EditSchoolViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishEditSchoolViewController(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
