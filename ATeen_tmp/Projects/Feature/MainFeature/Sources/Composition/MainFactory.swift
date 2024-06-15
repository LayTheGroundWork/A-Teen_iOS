//
//  MainFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import Common
import FeatureDependency
import UIKit

public protocol MainFactory {
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
    func makeReportCompleteDialogCoordinator(
        navigation: Navigation,
        delegate: ReportCompleteDialogCoordinatorDelegate
    ) -> Coordinator
}

public struct MainFactoryImp: MainFactory {
    let appContainer: AppContainer?
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        let viewModel = MainViewModel()
        viewModel.auth = appContainer?.auth
        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
    public func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        let factory = ProfileDetailFactoryImp(frame: frame, todayTeen: todayTeen)
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return ProfileDetailCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: [])
    }
    
    public func makeReportPopoverCoordinator(
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
    
    public func makeReportDialogCoordinator(
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
    
    public func makeReportCompleteDialogCoordinator(        
        navigation: Navigation,
        delegate: ReportCompleteDialogCoordinatorDelegate
    ) -> Coordinator {
        let factory = ReportCompleteDialogFactoryImp()
        return ReportCompleteDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
    }
}
