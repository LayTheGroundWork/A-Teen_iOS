//
//  SignUpCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import FeatureDependency
import Foundation

public protocol SignUpCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class SignUpCoordinator: Coordinator {
    public let phoneNumber: String
    public let coordinatorProvider: CoordinatorProvider
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    var factory: SignUpFactory
    weak var delegate: SignUpCoordinatorDelegate?
    
    public init(
        phoneNumber: String,
        coordinatorProvider: CoordinatorProvider,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: SignUpFactory,
        delegate: SignUpCoordinatorDelegate
    ) {
        self.phoneNumber = phoneNumber
        self.coordinatorProvider = coordinatorProvider
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSignUpViewController(
            phoneNumber: phoneNumber,
            coordinator: self
        )
        navigation.pushViewController(controller, animated: true)
    }
}

extension SignUpCoordinator: ParentCoordinator { }
