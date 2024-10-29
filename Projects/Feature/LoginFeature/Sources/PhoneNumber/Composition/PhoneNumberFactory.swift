//
//  PhoneNumberFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import Common
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
    public let signType: SignType
    
    public init(
        coordinatorProvider: CoordinatorProvider,
        signType: SignType
    ) {
        self.coordinatorProvider = coordinatorProvider
        self.signType = signType
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
