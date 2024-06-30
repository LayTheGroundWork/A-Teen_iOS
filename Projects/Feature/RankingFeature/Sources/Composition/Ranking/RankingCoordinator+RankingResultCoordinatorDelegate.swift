//
//  RankingCoordinator+RankingResultCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: RankingResultCoordinatorDelegate {
    public func didFinish(childCoordinator: FeatureDependency.Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
    }
    
    public func configTabbarStateInRankingResult(view: RankingFeatureViewNames) {
        configTabbarState(view: view)
    }
}
