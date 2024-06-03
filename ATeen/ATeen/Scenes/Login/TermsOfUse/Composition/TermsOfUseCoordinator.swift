//
//  TermsOfUseCoordinator.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import Foundation

protocol TermsOfUseCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

final class TermsOfUseCoordinator: Coordinator {
    var navigation: Navigation
    var factory: TermsOfUseFactory
    var childCoordinators: [Coordinator]
    weak var delegate: TermsOfUseCoordinatorDelegate?
    
    init(navigation: Navigation,
         factory: TermsOfUseFactory,
         childCoordinators: [Coordinator],
         delegate: TermsOfUseCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeTermsOfUseViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TermsOfUseCoordinator: ParentCoordinator { }
