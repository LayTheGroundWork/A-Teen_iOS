//
//  TrimVideoCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import FeatureDependency

public protocol TrimVideoCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class TrimVideoCoordinator: Coordinator {
    public let coordinatorProvider: CoordinatorProvider
    public var navigation: Navigation
    public var childCoordinators: [Coordinator] = []
    var factory: TrimVideoFactory
    let asset: AVAsset
    weak var delegate: TrimVideoCoordinatorDelegate?
    
    public init(
        coordinatorProvider: CoordinatorProvider,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: TrimVideoFactory,
        asset: AVAsset,
        delegate: TrimVideoCoordinatorDelegate
    ) {
        self.coordinatorProvider = coordinatorProvider
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.asset = asset
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeTrimVideoViewController(
            asset: asset,
            coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TrimVideoCoordinator: ParentCoordinator { }
