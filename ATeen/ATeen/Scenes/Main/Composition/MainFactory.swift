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
    func makeReportPopoverCoordinator(
        navigation: Navigation,
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate
    ) -> Coordinator
    func makeReportDialogCoordinator(
        navigation: Navigation,
        delegate: ReportDialogCoordinatorDelegate
    ) -> Coordinator
}

struct MainFactoryImp: MainFactory {
    let appContainer: AppContainer?
    
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        let viewModel = MainViewModel()
        viewModel.auth = appContainer?.auth
        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
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
    
    func makeReportPopoverCoordinator(
        navigation: Navigation,
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate
    ) -> Coordinator {
        let factory = ReportPopoverFactoryImp()
        return ReportPopoverCoordinator(
            navigation: navigation,
            factory: factory,
            popoverPosition: popoverPosition,
            delegate: delegate
        )
    }
    
    func makeReportDialogCoordinator(
        navigation: Navigation,
        delegate: ReportDialogCoordinatorDelegate
    ) -> Coordinator {
        let factory = ReportDialogFactoryImp()
        return ReportDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
    }
}
