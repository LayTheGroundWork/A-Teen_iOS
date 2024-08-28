//
//  CropImageFactory.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import FeatureDependency

public protocol CropImageFactory {
    func makeCropImageViewController(
        selectImage: UIImage,
        coordinator: CropImageViewControllerCoordinator
    ) -> UIViewController
    
    func makeSelectCategoryPhotoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SelectCategoryPhotoCoordinatorDelegate,
        selectImage: UIImage
    ) -> Coordinator
}

final class CropImageFactoryImp: CropImageFactory {
    func makeCropImageViewController(
        selectImage: UIImage,
        coordinator: CropImageViewControllerCoordinator
    ) -> UIViewController {
        let controller = CropImageViewController(
            selectImage: selectImage,
            coordinator: coordinator)
        return controller
    }
    
    public func makeSelectCategoryPhotoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SelectCategoryPhotoCoordinatorDelegate,
        selectImage: UIImage
    ) -> Coordinator {
        let factory = SelectCategoryPhotoFactoryImp()
        return SelectCategoryPhotoCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            selectImage: selectImage,
            delegate: delegate)
    }
}
