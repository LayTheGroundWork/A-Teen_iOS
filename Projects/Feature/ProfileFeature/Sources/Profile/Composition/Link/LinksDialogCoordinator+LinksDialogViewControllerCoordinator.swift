//
//  LinksDialogCoordinator+LinksDialogViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension LinksDialogCoordinator: LinksDialogViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
