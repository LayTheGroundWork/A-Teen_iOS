//
//  AlbumCoordinatorImp+CropImageCoordinatorDelegate.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension AlbumCoordinatorImp: CropImageCoordinatorDelegate, TrimVideoCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
}
