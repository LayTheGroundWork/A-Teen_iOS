//
//  SignUpCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import Foundation

final class SignUpCoordinator: Coordinator {
    var navigation: Navigation
    var factory: SignUpFactory
    
    init(navigation: Navigation,
         factory: SignUpFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeSignUpViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}
