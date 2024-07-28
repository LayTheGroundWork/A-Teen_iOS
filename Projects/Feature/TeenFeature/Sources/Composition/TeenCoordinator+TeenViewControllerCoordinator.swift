//
//  TeenCoordinator+TeenViewControllerCoordinator.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension TeenCoordinator: TeenViewControllerCoordinator {
    public func didSelectTeenCategory(with label: String) {
            let coordinator = factory.makeTeenDetailCoordinator(
                navigation: navigation,
                childCoordinators: childCoordinators,
                delegate: self,
                coordinatorProvider: coordinatorProvider,
                labelText: label)
            addChildCoordinatorStart(coordinator)
        }
}
