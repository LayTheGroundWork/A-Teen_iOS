//
//  SignUpFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import UIKit

protocol SignUpFactory {
    func makeSignUpViewController(coordinator: SignUpCoordinator) -> UIViewController
}

struct SignUpFactoryImp: SignUpFactory {
    func makeSignUpViewController(coordinator: SignUpCoordinator) -> UIViewController {
        let controller = SignUpViewController()
        return controller
    }
}

