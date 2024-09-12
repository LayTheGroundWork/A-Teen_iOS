//
//  EditSchoolCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol EditSchoolCoordinatorDelegate: AnyObject {
    func didFinishEditSchoolViewController(childCoordinator: Coordinator)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class EditSchoolCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: EditSchoolFactory
    weak var delegate: EditSchoolCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: EditSchoolFactory,
        delegate: EditSchoolCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeEditSchoolViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension EditSchoolCoordinator: ParentCoordinator { }

