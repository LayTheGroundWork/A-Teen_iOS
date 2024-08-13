//
//  ProfileDetailCoordinatorImp+ProfileDetailViewControllerCoordinator.swift
//  ProfileDetailFeature
//
//  Created by 최동호 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

extension ProfileDetailCoordinatorImp: ProfileDetailViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didTapSNSButton(
        contentViewController: UIViewController
    ) {
        let snsBottomSheetCoordinator = factory.makeSNSBottomSheetCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            contentViewController: contentViewController,
            delegate: self)
        
        addChildCoordinatorStart(snsBottomSheetCoordinator)
        
        snsBottomSheetCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.didFinish(childCoordinator: snsBottomSheetCoordinator)
        }
    }
}
