//
//  DefaultFactoryProvider.swift
//  App
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import MainFeature

import UIKit

final class DefaultFactoryProvider: FactoryProvider {
    func makeProfileDetailViewController(
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> UIViewController {
        let viewModel = ProfileDetailViewModel()
        let controller = ProfileDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator,
            frame: frame,
            todayTeen: todayTeen)
        
        controller.modalPresentationStyle = .overFullScreen
        
        return controller
    }
    
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let _ = ProfileDetailFactoryImp(frame: frame, todayTeen: todayTeen)
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return ProfileDetailCoordinatorImp(
            navigation: navigation,
            coordinatorProvider: coordinatorProvider,
            delegate: delegate,
            childCoordinators: [],
            frame: frame,
            todayTeen: todayTeen)
    }
}
