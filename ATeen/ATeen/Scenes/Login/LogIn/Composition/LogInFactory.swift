//
//  LogInFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol LogInFactory {
    func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController
    func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator]
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
    
    func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = TermsOfUseFactoryImp()
        return TermsOfUseCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators)
    }
}
