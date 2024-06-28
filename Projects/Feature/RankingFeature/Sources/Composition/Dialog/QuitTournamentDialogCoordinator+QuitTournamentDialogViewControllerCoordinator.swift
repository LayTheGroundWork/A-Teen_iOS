//
//  QuitTournamentDialogCoordinator+QuitTournamentDialogViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension QuitTournamentDialogCoordinator: QuitTournamentDialogViewControllerCoordinator {
    public func quitDialog() {
        delegate?.quitDialog(childCoordinator: self)
    }
    
    public func endTournament() {
        delegate?.endTournament(childCoordinator: self)
    }
}
