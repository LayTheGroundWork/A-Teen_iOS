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
    
    init(navigation: Navigation,
         factory: TermsOfUseFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeTermsOfUseViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
