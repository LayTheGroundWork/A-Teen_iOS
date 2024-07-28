//
//  MainTabCoordinator+ChatCoordinatorDelegate.swift
//  MainTabFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import ChatFeature
import UIKit

extension MainTabCoordinator: ChatCoordinatorDelegate {
    public func configTabbarState(view: ChatFeatureViewNames) {
        guard let tab = navigation.viewControllers.first as? MainTabController else { return }
        
        switch view {
        case .main:
            tab.showTabbar()
            
        case .chatRoom:
            tab.hideTabbar()
        }
    }
}
