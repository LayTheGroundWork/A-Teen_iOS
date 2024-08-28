//
//  SelectCategoryPhotoCoordinator+SelectCategoryPhotoViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

extension SelectCategoryPhotoCoordinator: SelectCategoryPhotoViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelect(image: UIImage) {
        delegate?.didFinish(childCoordinator: self)
        navigation.dismissNavigationFromAlbum?(AlbumType(image: image))
    }
}
