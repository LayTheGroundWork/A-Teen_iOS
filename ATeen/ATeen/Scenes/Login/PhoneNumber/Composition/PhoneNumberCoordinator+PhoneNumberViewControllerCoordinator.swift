//
//  PhoneNumberCoordinator+PhoneNumberViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

extension PhoneNumberCoordinator: PhoneNumberViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }

    func didSelectNextButton() {
        let coordinator = factory.makeTermsOfUseCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
    
    func didSelectResendCode() {
        // TODO: 코드 재전송
    }
}
