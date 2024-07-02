//
//  TrimVideoCoordinator+TrimVideoViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import FeatureDependency

extension TrimVideoCoordinator: TrimVideoViewControllerCoordinator {
    public func didSelectChecButton(asset: AVAsset) {
        print("hi")
    }
    
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
