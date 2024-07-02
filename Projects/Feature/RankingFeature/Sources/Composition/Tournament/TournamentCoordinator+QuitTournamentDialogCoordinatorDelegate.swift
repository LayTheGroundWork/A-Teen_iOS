//
//  TournamentCoordinator+QuitTournamentDialogCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension TournamentCoordinator: QuitTournamentDialogCoordinatorDelegate {
    public func quitDialog(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func endTournament(childCoordinator: Coordinator) {
        quitDialog(childCoordinator: childCoordinator)
        delegate?.quitTournament(childCoordinator: self)
    }
    
    public func configTabbarState(view: RankingFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
