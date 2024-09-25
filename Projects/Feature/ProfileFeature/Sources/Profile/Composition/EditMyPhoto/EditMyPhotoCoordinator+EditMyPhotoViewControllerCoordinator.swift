//
//  EditMyPhotoCoordinator+EditMyPhotoViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import Foundation

extension EditMyPhotoCoordinator: EditMyPhotoViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishEditMyPhoto(childCoordinator: self)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
    
    public func didSelectCell(item: Int) {
        let albumCoordinator = coordinatorProvider.makeAlbumCoordinator(
            delegate: self)
        addChildCoordinatorStart(albumCoordinator)
        navigation.present(
            albumCoordinator.navigation.rootViewController,
            animated: true)
        
        albumCoordinator.navigation.dismissNavigationFromAlbum = { [weak self] album in
            self?.didFinishAlbum(childCoordinator: albumCoordinator)
            self?.editMyPhotoViewControllerDelegate?.updateImage(index: item, selectItem: album)
        }
    }
    
    public func didTabCompleteButton() {
        delegate?.didFinishEditMyPhoto(childCoordinator: self)
    }
}
