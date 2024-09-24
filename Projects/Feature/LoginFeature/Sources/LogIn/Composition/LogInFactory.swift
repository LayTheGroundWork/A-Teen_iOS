//
//  LogInFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import Domain
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
    public let coordinatorProvider: CoordinatorProvider
    let viewModel = PhoneNumberViewModel()
    
    public init(
        coordinatorProvider: CoordinatorProvider
    ) {
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController {
       
        return LogInViewController(
            coordinator: coordinator,
            viewModel: viewModel)
    }
    
    public func makePhoneNumberCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: PhoneNumberCoordinatorDelegate
    ) -> Coordinator {
        let factory = PhoneNumberFactoryImp(
            coordinatorProvider: coordinatorProvider,
            signType: viewModel.signType
        )
        return PhoneNumberCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate, 
            coordinatorProvider: coordinatorProvider,
            viewModel: viewModel)
    }
}
