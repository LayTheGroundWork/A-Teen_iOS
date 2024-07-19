//
//  SettingsCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public protocol SettingsCoordinatorDelegate: AnyObject {
    func didTapLogOut()
}

public final class SettingsCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: SettingsFactory
    weak var delegate: SettingsCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: SettingsFactory,
        delegate: SettingsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeSettingsCotroller(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SettingsCoordinator: ParentCoordinator { }


