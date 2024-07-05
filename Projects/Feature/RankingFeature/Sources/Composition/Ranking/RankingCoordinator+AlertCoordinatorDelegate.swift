//
//  RankingCoordinator+AlertCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by 노주영 on 7/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        switch selectIndex {
        case 0:
            print("no")
        case 1:
            print("hi")
            let tournamentCoordinator = factory.makeTournamentCoordinator(
                navigation: navigation,
                delegate: self,
                coordinatorProvider: coordinatorProvider,
                sector: sector)
            addChildCoordinatorStart(tournamentCoordinator)
        default:
            break
        }
    }
}
