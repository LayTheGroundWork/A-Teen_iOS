//
//  SearchUserCoordinator.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol SearchUserCoordinatorDelegate: AnyObject {
    func didFinishSearchUser(childCoordinator: Coordinator)
    func configTabbarState(view: MainViewNames)
}

public final class SearchUserCoordinator: Coordinator {
    public var navigation: Navigation
    public var coordinatorProvider: CoordinatorProvider
    var factory: SearchUserFactory
    weak var delegate: SearchUserCoordinatorDelegate?
    public var childCoordinators: [Coordinator]

    public init(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        factory: SearchUserFactory,
        delegate: SearchUserCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.coordinatorProvider = coordinatorProvider
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }

    public func start() {
        let controller = factory.makeSearchUserViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SearchUserCoordinator: ParentCoordinator { }
