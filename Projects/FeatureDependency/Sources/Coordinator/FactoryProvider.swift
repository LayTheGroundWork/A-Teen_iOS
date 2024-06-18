//
//  FactoryProvider.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common

import UIKit

public protocol FactoryProvider {    
    func makeProfileDetailViewController(
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> UIViewController
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator
}
