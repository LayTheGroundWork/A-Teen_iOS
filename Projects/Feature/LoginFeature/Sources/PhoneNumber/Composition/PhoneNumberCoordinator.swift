//
//  PhoneNumberCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency
import Foundation

public protocol PhoneNumberCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func navigateToMainViewController()
}

public final class PhoneNumberCoordinator: Coordinator {
    public var navigation: Navigation
    var factory: PhoneNumberFactory
    public var childCoordinators: [Coordinator]
    weak var delegate: PhoneNumberCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        navigation: Navigation,
        factory: PhoneNumberFactory,
        childCoordinators: [Coordinator],
        delegate: PhoneNumberCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makePhoneNumberViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension PhoneNumberCoordinator: ParentCoordinator { }
