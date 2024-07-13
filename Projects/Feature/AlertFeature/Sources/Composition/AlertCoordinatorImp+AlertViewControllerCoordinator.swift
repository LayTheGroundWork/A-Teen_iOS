//
//  AlertCoordinator+AlertViewControllerCoordinator.swift
//  AlertFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension AlertCoordinator: AlertViewControllerCoordinator {
    public func didSelectButton() {
        navigation.dismissNavigation?()
        delegate?.didFinish(childCoordinator: self, selectIndex: 0)
    }
    
    public func didSelectSecondButton() {
        navigation.dismissNavigation?()
        delegate?.didFinish(childCoordinator: self, selectIndex: 1)
    }
}
