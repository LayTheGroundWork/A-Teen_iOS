//
//  MainFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator
}

struct MainFactoryImp: MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        let viewModel = MainViewModel()
        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.navigationItem.titleView =  CustomNaviView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        return controller
    }
    
    func makeProfileDetailCoordinator(
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
