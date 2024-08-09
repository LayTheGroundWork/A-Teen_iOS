//
//  TrimVideoFactory.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import FeatureDependency

public protocol TrimVideoFactory {
    func makeTrimVideoViewController(
        asset: AVAsset,
        coordinator: TrimVideoViewControllerCoordinator
    ) -> UIViewController
    
    func makeSelectCategoryVideoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SelectCategoryVideoCoordinatorDelegate,
        selectAsset: AVAsset
    ) -> Coordinator
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
    
    func makeSelectCategoryVideoCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SelectCategoryVideoCoordinatorDelegate,
        selectAsset: AVAsset
    ) -> Coordinator {
        let factory = SelectCategoryVideoFactoryImp()
        return SelectCategoryVideoCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            avAsset: selectAsset,
            delegate: delegate)
    }
}
