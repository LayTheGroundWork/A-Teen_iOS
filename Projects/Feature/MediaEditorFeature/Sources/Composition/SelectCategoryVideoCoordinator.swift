//
//  SelectCategoryVideoCoordinator.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVFoundation
import FeatureDependency
import UIKit

public protocol SelectCategoryVideoCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class SelectCategoryVideoCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    var factory: SelectCategoryVideoFactory
    let avAsset: AVAsset
    weak var delegate: SelectCategoryVideoCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: SelectCategoryVideoFactory,
        avAsset: AVAsset,
        delegate: SelectCategoryVideoCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.avAsset = avAsset
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSelectCategoryVideoViewController(
            selectAsset: avAsset,
            coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SelectCategoryVideoCoordinator: ParentCoordinator { }

