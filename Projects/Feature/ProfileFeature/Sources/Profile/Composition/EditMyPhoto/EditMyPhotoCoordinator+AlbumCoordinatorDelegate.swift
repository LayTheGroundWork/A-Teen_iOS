//
//  EditMyPhotoCoordinator+AlbumCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import Foundation

extension EditMyPhotoCoordinator: AlbumCoordinatorDelegate {
    public func didFinishAlbum(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        childCoordinator.navigation.dismissNavigationFromAlbum = nil
        removeChildCoordinator(childCoordinator)
        childCoordinator.navigation.dismiss(animated: true)
        
        guard let childCoordinator = childCoordinator as? ParentCoordinator else { return }
        childCoordinator.clearAllChildsCoordinator()
    }
}
