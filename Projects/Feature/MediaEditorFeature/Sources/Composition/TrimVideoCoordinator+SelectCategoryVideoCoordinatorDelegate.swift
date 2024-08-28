//
//  TrimVideoCoordinator+SelectCategoryVideoCoordinatorDelegate.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension TrimVideoCoordinator: SelectCategoryVideoCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
