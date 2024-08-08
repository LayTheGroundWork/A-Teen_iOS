//
//  SelectCategoryPhotoCoordinator+SelectCategoryPhotoViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

extension SelectCategoryPhotoCoordinator: SelectCategoryPhotoViewControllerCoordinator {
    public func didSelect(image: UIImage) {
        navigation.dismissNavigationFromAlbum?(image)
        
        navigation.dismiss(animated: true)
    }
}
