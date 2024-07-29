//
//  MainTabCoordinator+RankingCoordinatorDelegate.swift
//  MainTabFeature
//
//  Created by phang on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import RankingFeature
import UIKit

extension MainTabCoordinator: RankingCoordinatorDelegate {
    public func configTabbarState(view: RankingFeatureViewNames) {
        guard let tab = navigation.viewControllers.first as? MainTabController else { return }
        
        switch view {
        case .ranking:
            tab.showTabbar()
        case .tournament, .rankingResult:
            tab.hideTabbar()
        }
    }
}
