//
//  MainTabCoordinator+TeenCoordinatorDelegate.swift
//  MainTabFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import TeenFeature
import UIKit

extension MainTabCoordinator: TeenCoordinatorDelegate {
    
    // didSelectChattingButton -> MainTabCoordinator+MainCoordinatorDelegate
    
    public func configTabbarState(view: TeenFeatureViewNames) {
        guard let tab = navigation.viewControllers.first as? MainTabController else { return }
        
        switch view {
        case .teen:
            tab.showTabbar()
        case .teenDetail:
            tab.hideTabbar()
        }
    }
}
