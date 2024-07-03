//
//  TrimVideoFactory.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit

public protocol TrimVideoFactory {
    func makeTrimVideoViewController(
        asset: AVAsset,
        coordinator: TrimVideoViewControllerCoordinator
    ) -> UIViewController
}

final class TrimVideoFactoryImp: TrimVideoFactory {
    func makeTrimVideoViewController(
        asset: AVAsset,
        coordinator: TrimVideoViewControllerCoordinator
    ) -> UIViewController {
        let controller = TrimVideoControlViewController(
            asset: asset,
            coordinator: coordinator)
        return controller
    }
}
