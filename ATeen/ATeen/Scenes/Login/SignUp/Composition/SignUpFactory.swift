//
//  SignUpFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import UIKit

protocol SignUpFactory {
    func makeSignUpViewController(viewModel: LoginBirthViewModel, coordinator: SignUpCoordinator) -> UIViewController
    func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate,
        viewModel: LoginBirthViewModel,
        beforeYear: String,
        beforeMonth: String,
        beforeDay: String) -> Coordinator
}

struct SignUpFactoryImp: SignUpFactory {
    func makeSignUpViewController(
        viewModel: LoginBirthViewModel,
        coordinator: SignUpCoordinator
    ) -> UIViewController {
        let controller = SignUpViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    func makeSelectBirthCoordinator(
        delegate: SelectBirthCoordinatorDelegate,
        viewModel: LoginBirthViewModel,
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
    
    
    func makeSelectBirthCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        let factory = ProfileDetailFactoryImp(frame: frame, todayTeen: todayTeen)
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = .clear
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return ProfileDetailCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: [])
    }
}

