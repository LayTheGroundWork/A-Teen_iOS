//
//  LogInCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public protocol LogInCoordinatorDelegate: AnyObject {
    func didFinishLogin(childCoordinator: Coordinator)
}

public final class LogInCoordinator: Coordinator {
    public var navigation: Navigation
    var factory: LogInFactory
    weak var delegate: LogInCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        navigation: Navigation,
        factory: LogInFactory,
        delegate: LogInCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    public func start() {
        let controller = factory.makeLoginViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension LogInCoordinator: ParentCoordinator { }
