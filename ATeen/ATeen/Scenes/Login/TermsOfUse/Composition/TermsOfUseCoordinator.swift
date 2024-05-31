//
//  TermsOfUseCoordinator.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import Foundation

final class TermsOfUseCoordinator: Coordinator {
    var navigation: Navigation
    var factory: TermsOfUseFactory
    var childCoordinators: [Coordinator]
    
    init(navigation: Navigation,
         factory: TermsOfUseFactory,
         childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let controller = factory.makeTermsOfUseViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TermsOfUseCoordinator: ParentCoordinator { }
