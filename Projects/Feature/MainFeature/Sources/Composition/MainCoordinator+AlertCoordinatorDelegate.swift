//
//  MainCoordinator+AlertCoordinatorDelegate.swift
//  MainFeature
//
//  Created by 노주영 on 7/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension MainCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        didFinish(childCoordinator: childCoordinator)
        switch selectIndex {
        case 0:
            print("no")
        case 1:
            print("hi")
        default:
            break
        }
    }
}
