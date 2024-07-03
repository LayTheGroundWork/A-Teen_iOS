//
//  AlbumCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public final class AlbumCoordinator: Coordinator {
    public let factory: AlbumFactory
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    
    weak var delegate: AlbumCoordinatorDelegate?
    
    public init(
        factory: AlbumFactory,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: AlbumCoordinatorDelegate?) {
        self.factory = factory
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }

    public func start() {
        let controller = factory.makeAlbumViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension AlbumCoordinator: ParentCoordinator { }
