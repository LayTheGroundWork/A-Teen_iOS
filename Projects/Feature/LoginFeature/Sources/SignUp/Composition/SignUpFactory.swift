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
    func makeSignUpViewController(
        phoneNumber: String,
        coordinator: SignUpCoordinator
    ) -> UIViewController
    func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate
    ) -> Coordinator
}

public struct SignUpFactoryImp: SignUpFactory {
    let viewModel = SignUpViewModel()
    
    public func makeSignUpViewController(
        phoneNumber: String,
        coordinator: SignUpCoordinator
    ) -> UIViewController {
        viewModel.phoneNumber = phoneNumber
        let controller = SignUpViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    public func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate
    ) -> Coordinator {
        let factory = SelectBirthFactoryImp(
            viewModel: viewModel,
            beforeYear: viewModel.year,
            beforeMonth: viewModel.month,
            beforeDay: viewModel.day)
        
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return SelectBirthCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
}

