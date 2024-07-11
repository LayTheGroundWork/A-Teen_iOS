//
//  ProfileCoordinator+ProfileViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

import FeatureDependency

extension ProfileCoordinator: ProfileViewControllerCoordinator {
    public func didTabSettingButton() {
        guard let delegate = delegate else { return }
        let coordinator = factory.makeSettingCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: delegate,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabLinkButton() {
        let coordinator = factory.makeLinksDialogCoordinator(delegate: self)
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}
