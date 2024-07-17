//
//  TeenDetailCoordinator.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public final class TeenDetailCoordinator: Coordinator {
    public var navigation: Navigation
    private var factory: TeenDetailFactory
    public var childCoordinators: [Coordinator] = []
    public let coordinatorProvider: CoordinatorProvider
    public init(
        navigation: Navigation,
        factory: TeenDetailFactory,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeTeenDetailViewController()
        navigation.pushViewController(controller, animated: true)
    }
}

extension TeenDetailCoordinator: ParentCoordinator { }
