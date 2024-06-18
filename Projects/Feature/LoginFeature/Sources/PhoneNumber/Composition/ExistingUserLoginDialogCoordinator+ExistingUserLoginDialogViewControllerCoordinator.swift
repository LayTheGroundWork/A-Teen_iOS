//
//  ExistingUserLoginDialogCoordinator+ExistingUserLoginDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import Foundation

extension ExistingUserLoginDialogCoordinator: ExistingUserLoginDialogViewControllerCoordinator {
    public func navigateToMainViewController() {
        delegate?.navigateToMainViewController(childCoordinator: self)
    }
}