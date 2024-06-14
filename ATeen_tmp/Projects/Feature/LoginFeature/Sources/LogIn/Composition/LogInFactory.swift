//
//  LogInFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import FeatureDependency
import UIKit

public protocol LogInFactory {
    func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController
    func makePhoneNumberCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: PhoneNumberCoordinatorDelegate
    ) -> Coordinator
}

public struct LogInFactoryImp: LogInFactory {
    let appContainer: AppContainer?
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController {
        let viewModel = LogInViewModel(logInAuth: appContainer?.auth)
        return LogInViewController(
            coordinator: coordinator,
            viewModel: viewModel)
    }
    
    public func makePhoneNumberCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: PhoneNumberCoordinatorDelegate
    ) -> Coordinator {
        let factory = PhoneNumberFactoryImp()
        return PhoneNumberCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate)
    }
}
