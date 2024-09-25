//
//  CelebrateCoordinator.swift
//  LoginFeature
//
//  Created by 최동호 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol CelebrateCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class CelebrateCoordinator: Coordinator {
    public var navigation: Navigation
    var factory: CelebrateFactory
    weak var delegate: CelebrateCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: CelebrateFactory,
        delegate: CelebrateCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeCelebrateViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
