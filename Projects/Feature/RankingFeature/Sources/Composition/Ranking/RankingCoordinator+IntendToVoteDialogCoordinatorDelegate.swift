//
//  RankingCoordinator+IntendToVoteDialogCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension RankingCoordinator: IntendToVoteDialogCoordinatorDelegate {
    public func quitDialog(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func didTapParticipateInVote(
        childCoordinator: Coordinator,
        sector: String
    ) {
        quitDialog(childCoordinator: childCoordinator)
        let tournamentCoordinator = factory.makeTournamentCoordinator(
            navigation: navigation,
            delegate: self,
            sector: sector)
        addChildCoordinatorStart(tournamentCoordinator)
    }
}
