//
//  CropImageFactory.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol CropImageFactory {
    func makeCropImageViewController(
        selectImage: UIImage,
        coordinator: CropImageViewControllerCoordinator
    ) -> UIViewController
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
}
