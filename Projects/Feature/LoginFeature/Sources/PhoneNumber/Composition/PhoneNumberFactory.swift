//
//  PhoneNumberFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency
import UIKit

public protocol PhoneNumberFactory {
    func makePhoneNumberViewController(coordinator: PhoneNumberViewControllerCoordinator) -> UIViewController
    func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TermsOfUseCoordinatorDelegate
    ) -> Coordinator
}

public struct PhoneNumberFactoryImp: PhoneNumberFactory {
    
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        coordinatorProvider: CoordinatorProvider
    ) {
        self.coordinatorProvider = coordinatorProvider
    }
    public func makePhoneNumberViewController(coordinator: PhoneNumberViewControllerCoordinator) -> UIViewController {
        let controller = PhoneNumberViewController(coordinator: coordinator)
        return controller
    }
    
    public func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TermsOfUseCoordinatorDelegate
    ) -> Coordinator {
        let factory = TermsOfUseFactoryImp(
            coordinatorProvider: coordinatorProvider
        )
        return TermsOfUseCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate)
    }
}
