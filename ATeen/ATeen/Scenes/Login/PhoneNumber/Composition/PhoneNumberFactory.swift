//
//  PhoneNumberFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import UIKit

protocol PhoneNumberFactory {
    func makePhoneNumberViewController(coordinator: PhoneNumberViewControllerCoordinator) -> UIViewController
    func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TermsOfUseCoordinatorDelegate
    ) -> Coordinator
    func makeVerificationCompleteDialogCoordinator(
        navigation: Navigation,
        delegate: VerificationCompleteDialogCoordinatorDelegate
    ) -> Coordinator
    func makeExistingUserLoginDialogCoordinator(
        navigation: Navigation,
        delegate: ExistingUserLoginDialogCoordinatorDelegate
    ) -> Coordinator
}

struct PhoneNumberFactoryImp: PhoneNumberFactory {
    func makePhoneNumberViewController(coordinator: PhoneNumberViewControllerCoordinator) -> UIViewController {
        let controller = PhoneNumberViewController(coordinator: coordinator)
        return controller
    }
    
    func makeTermsOfUseCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TermsOfUseCoordinatorDelegate
    ) -> Coordinator {
        let factory = TermsOfUseFactoryImp()
        return TermsOfUseCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate)
    }
    
    func makeVerificationCompleteDialogCoordinator(
        navigation: Navigation,
        delegate: VerificationCompleteDialogCoordinatorDelegate
    ) -> Coordinator {
        let factory = VerificationCompleteDialogFactoryImp()
        return VerificationCompleteDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
    
    func makeExistingUserLoginDialogCoordinator(
        navigation: Navigation,
        delegate: ExistingUserLoginDialogCoordinatorDelegate
    ) -> Coordinator {
        let factory = ExistingUserLoginDialogFactoryImp()
        return ExistingUserLoginDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
}