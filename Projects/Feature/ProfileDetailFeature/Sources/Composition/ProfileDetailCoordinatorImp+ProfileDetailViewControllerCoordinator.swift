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
        contentViewController: UIViewController,
        defaultHeight: CGFloat
    ) {
        let snsBottomSheetCoordinator = factory.makeSNSBottomSheetCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            contentViewController: contentViewController,
            height: defaultHeight,
            delegate: self)
        
        addChildCoordinatorStart(snsBottomSheetCoordinator)
        
        snsBottomSheetCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.didFinish(childCoordinator: snsBottomSheetCoordinator)
        }
    }
}
