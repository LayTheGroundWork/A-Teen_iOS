//
//  TournamentCoordinator+AlertCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension TournamentCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        switch selectIndex {
        case 0:
            delegate?.quitTournament(childCoordinator: self)
        case 1:
            print("hi")
        default:
            break
        }
    }
}
