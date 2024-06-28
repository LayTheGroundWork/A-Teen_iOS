//
//  RankingCoordinator+RankingViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: RankingViewControllerCoordinator {
    public func didTapVoteButton(sector: String) {
        let intendToVorwDialogCoordinator = factory.makeIntendToVoteDialogCoordinator(
            navigation: navigation,
            delegate: self,
            sector: sector)
        addChildCoordinatorStart(intendToVorwDialogCoordinator)
    }
    
    public func didTapRankingCollectionViewCell(sector: String) {
        let rankingResultCoordinator = factory.makeRankingResultCoordinator(
            navigation: navigation,
            delegate: self,
            sector: sector)
        addChildCoordinatorStart(rankingResultCoordinator)
    }
}
