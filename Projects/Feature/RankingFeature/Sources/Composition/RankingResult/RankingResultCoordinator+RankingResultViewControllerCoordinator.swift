//
//  RankingResultCoordinator+RankingResultViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension RankingResultCoordinator: RankingResultViewControllerCoordinator {
    public func didTapBackButton() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func configTabbarState(view: RankingFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
