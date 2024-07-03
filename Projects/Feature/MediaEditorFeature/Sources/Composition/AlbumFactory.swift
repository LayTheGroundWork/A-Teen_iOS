//
//  AlbumFactory.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import Common
import FeatureDependency

public protocol AlbumFactory {
    func makeAlbumViewController(coordinator: AlbumViewControllerCoordinator) -> UIViewController
    
    func makeCropImageCoordinator(
        selectImage: UIImage,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: CropImageCoordinatorDelegate
    ) -> Coordinator
    
    func makeTrimVideoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        asset: AVAsset,
        delegate: TrimVideoCoordinatorDelegate
    ) -> Coordinator
}

public struct AlbumFactoryImp: AlbumFactory {
    public init() { }
    
    public func makeAlbumViewController(coordinator: AlbumViewControllerCoordinator) -> UIViewController {
        let controller = AlbumViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        
        return controller
    }
    
    public func makeCropImageCoordinator(
        selectImage: UIImage,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: CropImageCoordinatorDelegate
    ) -> Coordinator {
        let factory = CropImageFactoryImp()
        return CropImageCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            selectImage: selectImage,
            delegate: delegate)
    }
    
    public func makeTrimVideoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        asset: AVAsset,
        delegate: TrimVideoCoordinatorDelegate
    ) -> Coordinator {
        let factory = TrimVideoFactoryImp()
        return TrimVideoCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            asset: asset,
            delegate: delegate)
    }
}
