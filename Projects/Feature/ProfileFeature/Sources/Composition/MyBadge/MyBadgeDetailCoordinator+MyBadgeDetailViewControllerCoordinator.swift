//
//  MyBadgeDetailCoordinator+MyBadgeDetailViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension MyBadgeDetailCoordinator: MyBadgeDetailViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
