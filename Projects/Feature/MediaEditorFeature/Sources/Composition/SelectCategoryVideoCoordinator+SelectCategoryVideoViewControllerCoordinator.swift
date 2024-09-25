//
//  SelectCategoryVideoCoordinator+SelectCategoryVideoViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVFoundation
import Common

extension SelectCategoryVideoCoordinator: SelectCategoryVideoViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelect(avAsset: AVAsset) {
        delegate?.didFinish(childCoordinator: self)
        navigation.dismissNavigationFromAlbum?(AlbumType(avAsset: avAsset))
    }
}
