//
//  TermsOfUseCoordinator+TermsOfUseViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

extension TermsOfUseCoordinator: TermsOfUseViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    func didSelectNextButton() {
        let coordinator = factory.makeSignUpCoordinator(navigation: navigation, childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
}
