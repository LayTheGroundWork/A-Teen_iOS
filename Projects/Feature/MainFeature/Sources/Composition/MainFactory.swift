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

public struct MainFactoryImp: MainFactory {
    let appContainer: AppContainer?
    let viewModel = MainViewModel()
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        viewModel.auth = appContainer?.auth
        let controller = MainViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
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
}
