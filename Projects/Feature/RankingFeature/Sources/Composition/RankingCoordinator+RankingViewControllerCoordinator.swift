//
//  RankingCoordinator+RankingViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension RankingCoordinator: RankingViewControllerCoordinator {
    public func didTapVoteButton(sector: String) {
        let intendToVorwDialogCoordinator = factory.makeIntendToVoteDialogCoordinator(
            navigation: navigation,
            delegate: self,
            sector: sector)
        addChildCoordinatorStart(intendToVorwDialogCoordinator)
    }
}
