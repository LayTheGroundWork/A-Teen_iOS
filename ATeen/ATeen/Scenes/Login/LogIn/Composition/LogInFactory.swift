//
//  LogInFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol LogInFactory {
    func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController
    func makeSignUpCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SignUpCoordinatorDelegate
    ) -> Coordinator
}

struct LogInFactoryImp: LogInFactory {
    let appContainer: AppContainer?
    
    func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController {
        let viewModel = LogInViewModel(logInAuth: appContainer?.auth)
        return LogInViewController(
            coordinator: coordinator,
            viewModel: viewModel)
    }
    
    func makeSignUpCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SignUpCoordinatorDelegate
    ) -> Coordinator {
        let factory = SignUpFactoryImp()
        return SignUpCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate)
    }
}
