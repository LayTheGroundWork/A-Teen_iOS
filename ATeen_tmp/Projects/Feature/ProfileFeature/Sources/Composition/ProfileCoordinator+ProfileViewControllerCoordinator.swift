//
//  ProfileCoordinator+ProfileViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

import FeatureDependency

extension ProfileCoordinator: ProfileViewControllerCoordinator {
    func didTabSettingButton() {
        guard let delegate = delegate else { return }
        let coordinator = factory.makeSettingCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: delegate,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
}
