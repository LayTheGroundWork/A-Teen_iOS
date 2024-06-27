//
//  IntendToVoteDialogCoordinator+IntendToVoteDialogViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

extension IntendToVoteDialogCoordinator: IntendToVoteDialogViewControllerCoordinator {
    func quitDialog() {
        delegate?.quitDialog(childCoordinator: self)
    }
    
    func didTapParticipateInVote() {
        delegate?.didTapParticipateInVote(childCoordinator: self)
    }
}
