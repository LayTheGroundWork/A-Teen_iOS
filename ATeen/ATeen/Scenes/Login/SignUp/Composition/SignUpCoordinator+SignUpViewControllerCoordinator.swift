//
//  SignUpCoordinator+SignUpViewControllerCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import Foundation

extension SignUpCoordinator: SignUpViewControllerCoordinator {
    func didSelectBirth() {
        let selectBirthCoordinator = factory.makeSelectBirthCoordinator(
            delegate: self,
            viewModel: viewModel,
            beforeYear: viewModel.year,
            beforeMonth: viewModel.month,
            beforeDay: viewModel.day)
        
        addChildCoordinatorStart(selectBirthCoordinator)
        
        navigation.present(
            selectBirthCoordinator.navigation.rootViewController,
            animated: false)
        
        selectBirthCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(selectBirthCoordinator)
        }
    }
    
    func didSelectService() {
        print("123421412")
    }
}
