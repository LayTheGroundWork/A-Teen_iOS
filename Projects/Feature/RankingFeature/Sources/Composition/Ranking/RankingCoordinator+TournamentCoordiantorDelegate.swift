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
    
    public func finishTournament(
        childCoordinator: Coordinator,
        sector: String,
        session: String
    ) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: false)
        //
        let rankingResultCoordinator = factory.makeRankingResultCoordinator(
            navigation: navigation,
            delegate: self,
            withAnimation: false,
            sector: sector,
            session: session)
        addChildCoordinatorStart(rankingResultCoordinator)
    }
}
