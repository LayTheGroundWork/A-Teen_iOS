//
//  PhoneNumberCoordinator+VerificationCompleteDialogCoordinatorDelegate.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

extension PhoneNumberCoordinator: VerificationCompleteDialogCoordinatorDelegate,
                                  ExistingUserLoginDialogCoordinatorDelegate {
    func didSelectNextButton(registrationStatus: RegistrationStatus) {
        if registrationStatus == .notSignedUp {
            let coordinator = factory.makeVerificationCompleteDialogCoordinator(
                navigation: navigation,
                delegate: self)
            addChildCoordinatorStart(coordinator)
        } else {
            let coordinator = factory.makeExistingUserLoginDialogCoordinator(
                navigation: navigation,
                delegate: self)
            addChildCoordinatorStart(coordinator)
        }
    }
    
    func didSelectOKButton(childCoordinator: Coordinator) {
        // 현재 Dialog 닫기
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        // 이후 화면 이동
        let coordinator = factory.makeTermsOfUseCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
