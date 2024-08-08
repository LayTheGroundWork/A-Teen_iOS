//
//  SignUpCoordinator+AlbumCoordinatorDelegate.swift
//  LoginFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import Foundation

extension SignUpCoordinator: AlbumCoordinatorDelegate {
    public func didFinishAlbum(childCoordinator: Coordinator) {
        print("이거 왜 안되냐")
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: true)
        
        guard let childCoordinator = childCoordinator as? ParentCoordinator else { return }
        childCoordinator.clearAllChildsCoordinator()
    }
}
