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
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    var factory: SignUpFactory
    var viewModel = LoginBirthViewModel()
    weak var delegate: SignUpCoordinatorDelegate?
    
    public init(navigation: Navigation,
         factory: SignUpFactory,
         childCoordinators: [Coordinator],
         delegate: SignUpCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSignUpViewController(viewModel: viewModel, coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SignUpCoordinator: ParentCoordinator { }
