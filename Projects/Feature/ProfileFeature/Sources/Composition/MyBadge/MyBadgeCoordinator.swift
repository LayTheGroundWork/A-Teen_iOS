//
//  MyBadgeCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol MyBadgeCoordinatorDelegate: AnyObject {
    func didFinishMyBadgeViewController(childCoordinator: Coordinator)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class MyBadgeCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: MyBadgeFactory
    weak var delegate: MyBadgeCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: MyBadgeFactory,
        delegate: MyBadgeCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeMyBadgeViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension MyBadgeCoordinator: ParentCoordinator { }

