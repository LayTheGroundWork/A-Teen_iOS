//
//  LinksDialogCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol LinksDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class LinksDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: LinksDialogFactory
    weak var delegate: LinksDialogCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []

    public init(
        navigation: Navigation,
        factory: LinksDialogFactory,
        delegate: LinksDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeLinksDialogViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}
