//
//  AlbumCoordinator.swift
//  FeatureDependency
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit

public protocol AlbumCoordinator: Coordinator {
    func didFinishFlow()
}

public protocol AlbumViewControllerCoordinator: AnyObject {
    func didFinishFlow()
    func didSelectPhoto(selectImage: UIImage)
    func didSelectVideo(asset: AVAsset)
}
