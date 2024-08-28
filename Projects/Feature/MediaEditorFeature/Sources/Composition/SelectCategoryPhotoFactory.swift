//
//  SelectCategoryPhotoFactory.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol SelectCategoryPhotoFactory {
    func makeSelectCategoryPhotoViewController(
        selectImage: UIImage,
        coordinator: SelectCategoryPhotoViewControllerCoordinator
    ) -> UIViewController
}

final class SelectCategoryPhotoFactoryImp: SelectCategoryPhotoFactory {
    func makeSelectCategoryPhotoViewController(
        selectImage: UIImage,
        coordinator: SelectCategoryPhotoViewControllerCoordinator
    ) -> UIViewController {
        let controller = SelectCategoryPhotoViewController(
            selectImage: selectImage,
            coordinator: coordinator)
        return controller
    }
}
