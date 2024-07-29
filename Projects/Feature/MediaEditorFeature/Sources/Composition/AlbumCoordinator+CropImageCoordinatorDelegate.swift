//
//  AlbumCoordinator+CropImageCoordinatorDelegate.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension AlbumCoordinator: CropImageCoordinatorDelegate, TrimVideoCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
