//
//  ProfileCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public final class ProfileCoordinator: Coordinator {
    public var navigation: Navigation
    var factory: ProfileFactory
    weak var delegate: SettingsCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    
    public init(
        navigation: Navigation,
        factory: ProfileFactory,
        delegate: SettingsCoordinatorDelegate

    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate

    }
    
    public func start() {
        let controller = factory.makeProfileViewController(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension ProfileCoordinator: ParentCoordinator { }
