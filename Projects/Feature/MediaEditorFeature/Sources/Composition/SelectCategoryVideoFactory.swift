//
//  SelectCategoryVideoFactory.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVFoundation
import UIKit

public protocol SelectCategoryVideoFactory {
    func makeSelectCategoryVideoViewController(
        selectAsset: AVAsset,
        coordinator: SelectCategoryVideoViewControllerCoordinator
    ) -> UIViewController
}

final class SelectCategoryVideoFactoryImp: SelectCategoryVideoFactory {
    func makeSelectCategoryVideoViewController(
        selectAsset: AVAsset,
        coordinator: SelectCategoryVideoViewControllerCoordinator
    ) -> UIViewController {
        let controller = SelectCategoryVideoViewController(
            asset: selectAsset,
            coordinator: coordinator)
        return controller
    }
}

