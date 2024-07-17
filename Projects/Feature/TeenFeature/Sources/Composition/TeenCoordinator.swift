//
//  TeenCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Common
import FeatureDependency
import UIKit

public final class TeenCoordinator: Coordinator {
    public var navigation: Navigation
    private var factory: TeenFactory
    public var childCoordinators: [Coordinator] = []
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        navigation: Navigation,
        factory: TeenFactory,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeTeenViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension TeenCoordinator: ParentCoordinator { }
