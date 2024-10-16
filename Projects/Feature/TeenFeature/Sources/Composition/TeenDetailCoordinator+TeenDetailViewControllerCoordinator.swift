//
//  TeenDetailCoordinator+TeenDetailViewControllerCoordinator.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import Domain
import FeatureDependency
import UIKit

extension TeenDetailCoordinator: TeenDetailViewControllerCoordinator {
    public func didTapBackButton() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelectTeenImage(
        frame: CGRect,
        teen: UserData,
        todayTeenFirstImage: UIImage
    ) {
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
            delegate: self,
            frame: frame,
            todayTeen: teen,
            todayTeenFirstImage: todayTeenFirstImage)
        
        addChildCoordinatorStart(profileDetailCoordinator)
        
        navigation.present(
            profileDetailCoordinator.navigation.rootViewController,
            animated: false)
        
        profileDetailCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(profileDetailCoordinator)
        }
    }
    
    public func didSelectTeenChattingButton() {
        delegate?.didSelectChattingButton()
    }
    
    public func didSelectMenuButton(popoverPosition: CGRect) {
        let reportPopoverCoordinator = coordinatorProvider.makePopoverCoordinator(
            popoverPosition: popoverPosition,
            delegate: self)
        addChildCoordinatorStart(reportPopoverCoordinator)
        
        navigation.present(
            reportPopoverCoordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func configTabbarState(view: TeenFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
