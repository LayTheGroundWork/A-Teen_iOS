//
//  CoordinatorProvider.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

public protocol CoordinatorProvider {
    func makeProfileDetailViewController(
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> UIViewController
    
    func moveToProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator
}

public protocol ProfileDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
