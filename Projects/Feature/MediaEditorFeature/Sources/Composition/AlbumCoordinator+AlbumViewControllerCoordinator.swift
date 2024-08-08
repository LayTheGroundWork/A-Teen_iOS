//
//  AlbumCoordinator+AlbumViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import FeatureDependency

extension AlbumCoordinator: AlbumViewControllerCoordinator {
    public func didSelectPhoto(selectImage: UIImage) {
        let cropImageCoordinator = factory.makeCropImageCoordinator(
            selectImage: selectImage,
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(cropImageCoordinator)
    }
    
    public func didSelectVideo(asset: AVAsset) {
        let trimVideoCoordinator = factory.makeTrimVideoCoordinator(
            coordinatorProvider: coordinatorProvider,
            navigation: navigation,
            childCoordinators: childCoordinators,
            asset: asset,
            delegate: self)
        addChildCoordinatorStart(trimVideoCoordinator)
    }
    
    public func didFinishFlow() {
        delegate?.didFinishAlbum(childCoordinator: self)
    }
}
