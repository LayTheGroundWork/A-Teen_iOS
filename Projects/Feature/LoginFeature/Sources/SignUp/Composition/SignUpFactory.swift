//
//  SignUpFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import Common
import FeatureDependency
import UIKit

public protocol SignUpFactory {
    func makeSignUpViewController(viewModel: SignUpViewModel, coordinator: SignUpCoordinator) -> UIViewController
    func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate,
        viewModel: SignUpViewModel,
        beforeYear: String,
        beforeMonth: String,
        beforeDay: String) -> Coordinator
}

public struct SignUpFactoryImp: SignUpFactory {
    public func makeSignUpViewController(
        viewModel: SignUpViewModel,
        coordinator: SignUpCoordinator
    ) -> UIViewController {
        let controller = SignUpViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    public func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate,
        viewModel: SignUpViewModel,
        beforeYear: String,
        beforeMonth: String,
        beforeDay: String
    ) -> Coordinator {
        let factory = SelectBirthFactoryImp(
            viewModel: viewModel,
            beforeYear: beforeYear,
            beforeMonth: beforeMonth, 
            beforeDay: beforeDay)
        
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return SelectBirthCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
}

