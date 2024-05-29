//
//  SignUpCoordinator+TermsOfUseViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

extension TermsOfUseCoordinator: TermsOfUseViewControllerCoordinator {
    func didSelectNextButton() {
        let coordinator = factory.makeSignUpCoordinator(navigation: self.navigation)
        addChildCoordinatorStart(coordinator)
    }
}
