//
//  IntroduceCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol IntroduceCoordinatorDelegate: AnyObject {
    func didFinishIntroduceViewController(childCoordinator: Coordinator)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class IntroduceCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: IntroduceFactory
    weak var delegate: IntroduceCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: IntroduceFactory,
        delegate: IntroduceCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeIntroduceViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
