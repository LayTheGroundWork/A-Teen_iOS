//
//  EditMyPhotoCoordinator+EditMyPhotoViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension EditMyPhotoCoordinator: EditMyPhotoViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishEditMyPhoto(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
