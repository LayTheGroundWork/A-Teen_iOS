//
//  TermsOfUseFactory.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import FeatureDependency
import UIKit

public protocol TermsOfUseFactory {
    func makeTermsOfUseViewController(coordinator: TermsOfUseViewControllerCoordinator) -> UIViewController
    func makeSignUpCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SignUpCoordinatorDelegate
    ) -> Coordinator
}

public struct TermsOfUseFactoryImp: TermsOfUseFactory {
    public let coordinatorProvider: CoordinatorProvider
    public init(
        coordinatorProvider: CoordinatorProvider
    ) {
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func makeTermsOfUseViewController(coordinator: TermsOfUseViewControllerCoordinator) -> UIViewController {
        let controller = TermsOfUseViewController(coordinator: coordinator)
        return controller
    }
    
    public func makeSignUpCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: SignUpCoordinatorDelegate
    ) -> Coordinator {
        let factory = SignUpFactoryImp()
        return SignUpCoordinator(
            coordinatorProvider: coordinatorProvider,
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            delegate: delegate)
    }
}
