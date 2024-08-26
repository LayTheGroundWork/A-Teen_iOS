//
//  MainTabCoordinator+ProfileCoordinatorDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import ProfileFeature
import UIKit

extension MainTabCoordinator: ProfileCoordinatorDelegate {
    public func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
    
    public func configTabbarState(view: ProfileFeature.ProfileFeatureViewNames) {
        guard let tab = navigation.viewControllers.first as? MainTabController else { return }
        
        switch view {
        case .profile:
            tab.showTabbar()
            
        case .introduce, .question, .editPhoto:
            tab.hideTabbar()
        }
    }
}
