//
//  TermsOfUseFactory.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import UIKit

protocol TermsOfUseFactory {
    func makeTermsOfUseViewController(coordinator: TermsOfUseViewControllerCoordinator) -> UIViewController
    func makeSignUpCoordinator(navigation: Navigation) -> Coordinator
}

struct TermsOfUseFactoryImp: TermsOfUseFactory {
    func makeTermsOfUseViewController(coordinator: TermsOfUseViewControllerCoordinator) -> UIViewController {
        let controller = TermsOfUseViewController(coordinator: coordinator)
        return controller
    }
    
    func makeSignUpCoordinator(navigation: Navigation) -> Coordinator {
        let factory = SignUpFactoryImp()
        return SignUpCoordinator(navigation: navigation, factory: factory)
    }
}
