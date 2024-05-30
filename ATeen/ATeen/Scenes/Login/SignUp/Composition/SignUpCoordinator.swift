//
//  SignUpCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import Foundation

protocol SignUpCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

final class SignUpCoordinator: Coordinator {
    var navigation: Navigation
    var factory: SignUpFactory
    var childCoordinators: [Coordinator]
    var viewModel = LoginBirthViewModel()
    weak var delegate: SignUpCoordinatorDelegate?
    
    init(navigation: Navigation,
         factory: SignUpFactory,
         childCoordinators: [Coordinator],
         delegate: SignUpCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeSignUpViewController(viewModel: viewModel, coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SignUpCoordinator: ParentCoordinator { }
