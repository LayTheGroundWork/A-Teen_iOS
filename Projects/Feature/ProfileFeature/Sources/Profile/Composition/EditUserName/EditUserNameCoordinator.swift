//
//  EditUserNameCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Domain
import FeatureDependency
import UIKit

public protocol EditUserNameCoordinatorDelegate: AnyObject {
    func didFinishUserNameViewController(childCoordinator: Coordinator, user: MyPageData)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class EditUserNameCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: EditUserNameFactory
    weak var delegate: EditUserNameCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: EditUserNameFactory,
        delegate: EditUserNameCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeUserNameViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension EditUserNameCoordinator: ParentCoordinator { }


