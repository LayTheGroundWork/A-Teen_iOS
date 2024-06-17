//
//  TermsOfUseCoordinator+TermsOfUseViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import FeatureDependency

extension TermsOfUseCoordinator: TermsOfUseViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelectNextButton() {
        let coordinator = factory.makeSignUpCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
}
