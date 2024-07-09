//
//  PhoneNumberFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency
import UIKit

public protocol PhoneNumberFactory {
    func makePhoneNumberViewController(
        coordinator: PhoneNumberViewControllerCoordinator,
        viewModel: PhoneNumberViewModel
    ) -> UIViewController
    func makeTermsOfUseCoordinator(
        phoneNumber: String,
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
    public func makePhoneNumberViewController(
        coordinator: PhoneNumberViewControllerCoordinator,
        viewModel: PhoneNumberViewModel
    ) -> UIViewController {
        let controller = PhoneNumberViewController(
            coordinator: coordinator,
            viewModel: viewModel
        )
        return controller
    }
    
    public func makeTermsOfUseCoordinator(
        phoneNumber: String,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TermsOfUseCoordinatorDelegate
    ) -> Coordinator {
        let factory = TermsOfUseFactoryImp(
            coordinatorProvider: coordinatorProvider
        )
        return TermsOfUseCoordinator(
            phoneNumber: phoneNumber,
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate)
    }
}
