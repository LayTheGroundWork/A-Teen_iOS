//
//  PhoneNumberCoordinator+PhoneNumberViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import FeatureDependency

extension PhoneNumberCoordinator: PhoneNumberViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelectResendCode() {
        // TODO: 코드 재전송
    }
    
    public func openVerificationCompleteDialog() {
        let coordinator = factory.makeVerificationCompleteDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
    
    public func openExistingUserLoginDialog() {
        let coordinator = factory.makeExistingUserLoginDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
