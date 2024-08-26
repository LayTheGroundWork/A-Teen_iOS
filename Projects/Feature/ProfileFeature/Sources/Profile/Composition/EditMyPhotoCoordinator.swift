//
//  EditMyPhotoCoordinator.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import Foundation

public protocol EditMyPhotoCoordinatorDelegate: AnyObject {
    func didFinishEditMyPhoto(childCoordinator: Coordinator)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class EditMyPhotoCoordinator: Coordinator {
    public var navigation: Navigation
    public let coordinatorProvider: CoordinatorProvider
    public var childCoordinators: [Coordinator]
    var factory: EditMyPhotoFactory
    weak var delegate: EditMyPhotoCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        childCoordinators: [Coordinator],
        factory: EditMyPhotoFactory,
        delegate: EditMyPhotoCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.coordinatorProvider = coordinatorProvider
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.delegate = delegate
    }

    public func start() {
        let controller = factory.makeEditMyPhotoViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension EditMyPhotoCoordinator: ParentCoordinator { }
