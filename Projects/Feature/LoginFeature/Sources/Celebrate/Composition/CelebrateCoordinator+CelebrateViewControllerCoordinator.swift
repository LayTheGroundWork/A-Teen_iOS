//
//  CelebrateCoordinator+CelebrateViewControllerCoordinator.swift
//  LoginFeature
//
//  Created by 최동호 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension CelebrateCoordinator: CelebrateViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
