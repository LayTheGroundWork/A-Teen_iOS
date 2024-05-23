//
//  ProfileCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var navigation: Navigation
    var factory: ProfileFactory
    weak var delegate: SettingsCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: ProfileFactory,
        delegate: SettingsCoordinatorDelegate

    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate

    }
    
    func start() {
        let controller = factory.makeProfileViewController(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

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

extension ProfileCoordinator: ParentCoordinator { }
