//
//  ReportPopoverFactory.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import Common
import FeatureDependency
import UIKit

public protocol ReportPopoverFactory {
    func makeReportPopoverViewController(
        coordinator: ReportPopoverCoordinator,
        popoverPosition: CGRect
    ) -> UIViewController
    
    func makeReportDialogCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: ReportDialogCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        dialogType: ReportDialogType
    ) -> Coordinator
}

public struct ReportPopoverFactoryImp: ReportPopoverFactory {
    public init() { }
    
    public func makeReportPopoverViewController(
        coordinator: ReportPopoverCoordinator,
        popoverPosition: CGRect
    ) -> UIViewController {
        let controller = ReportPopoverViewController(
            coordinator: coordinator,
            popoverPosition: popoverPosition)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
    
    public func makeReportDialogCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: ReportDialogCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        dialogType: ReportDialogType
    ) -> Coordinator {
        let factory = ReportDialogFactoryImp()
        return ReportDialogCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            factory: factory,
            dialogType: dialogType,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider)
    }
}
