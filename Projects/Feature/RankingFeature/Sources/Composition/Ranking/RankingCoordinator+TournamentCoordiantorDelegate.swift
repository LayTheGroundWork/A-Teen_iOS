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
        category: String,
        round: Int,
        tournamentNo: Int
    ) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: false)
        
        let rankingResultCoordinator = factory.makeRankingResultCoordinator(
            navigation: navigation,
            delegate: self,
            withAnimation: false,
            category: category,
            round: round,
            tournamentNo: tournamentNo)
        addChildCoordinatorStart(rankingResultCoordinator)
    }
}
