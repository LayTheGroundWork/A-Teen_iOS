//
//  TournamentCoordinator+TournamentViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension TournamentCoordinator: TournamentViewControllerCoordinator {
    public func quitTournament() {
        delegate?.quitTournament(childCoordinator: self)
    }
    
    public func openQuitDialog() {
        let quitTournamentDialogCoordinator = factory.makeQuitTournamentDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(quitTournamentDialogCoordinator)
    }
}
