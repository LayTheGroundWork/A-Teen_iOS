//
//  EditUserNameCoordinator+EditUserNameViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension EditUserNameCoordinator: EditUserNameViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishUserNameViewController(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
