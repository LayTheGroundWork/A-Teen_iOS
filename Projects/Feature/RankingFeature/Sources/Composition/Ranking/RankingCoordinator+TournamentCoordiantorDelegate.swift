//
//  RankingCoordinator+TournamentCoordiantorDelegate.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: TournamentCoordinatorDelegate {
    public func quitTournament(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func configTabbarStateInTournament(view: RankingFeatureViewNames) {
        configTabbarState(view: view)
    }
}
