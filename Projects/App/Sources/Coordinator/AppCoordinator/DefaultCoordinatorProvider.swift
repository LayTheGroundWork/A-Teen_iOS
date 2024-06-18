//
//  DefaultCoordinatorProvider.swift
//  App
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import MainFeature

import UIKit

final class DefaultCoordinatorProvider: CoordinatorProvider {
    let factoryProvider = DefaultFactoryProvider()
}

// MARK: - ProfileDetail
extension DefaultCoordinatorProvider {
    func makeProfileDetailViewController(
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> UIViewController {
        factoryProvider.makeProfileDetailViewController(
            coordinator: coordinator,
            frame: frame,
            todayTeen: todayTeen)
    }
    
    func moveToProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        factoryProvider.makeProfileDetailCoordinator(
            delegate: delegate,
            frame: frame,
            todayTeen: todayTeen,
            coordinatorProvider: self)
    }
}
