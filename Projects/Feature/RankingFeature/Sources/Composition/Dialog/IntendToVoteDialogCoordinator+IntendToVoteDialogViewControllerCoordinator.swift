//
//  IntendToVoteDialogCoordinator+IntendToVoteDialogViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension IntendToVoteDialogCoordinator: IntendToVoteDialogViewControllerCoordinator {
    public func quitDialog() {
        delegate?.quitDialog(childCoordinator: self)
    }
    
    public func didTapParticipateInVote(sector: String) {
        delegate?.didTapParticipateInVote(childCoordinator: self, sector: sector)
    }
}
