//
//  MyBadgeDetailCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol MyBadgeDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class MyBadgeDetailCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: MyBadgeDetailFactory
    weak var delegate: MyBadgeDetailCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []

    public init(
        navigation: Navigation,
        factory: MyBadgeDetailFactory,
        delegate: MyBadgeDetailCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeMyBadgeDetailViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

