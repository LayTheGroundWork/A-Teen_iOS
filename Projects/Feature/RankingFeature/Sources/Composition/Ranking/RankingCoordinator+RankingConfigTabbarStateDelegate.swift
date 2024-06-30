//
//  RankingCoordinator+RankingConfigTabbarStateDelegate.swift
//  RankingFeature
//
//  Created by phang on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: RankingConfigTabbarStateDelegate {
    public func configTabbarState(view: RankingFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
