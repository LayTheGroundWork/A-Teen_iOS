//
//  CropImageCoordinator+SelectCategoryPhotoCoordinatorDelegate.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension CropImageCoordinator: SelectCategoryPhotoCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
