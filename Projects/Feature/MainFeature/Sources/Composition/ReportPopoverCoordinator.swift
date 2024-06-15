//
//  ReportPopoverCoordinator.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import FeatureDependency
import UIKit

public protocol ReportPopoverCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didSelectReportButton(childCoordinator: Coordinator)
}

public final class ReportPopoverCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: ReportPopoverFactory
    let popoverPosition: CGRect
    weak var delegate: ReportPopoverCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: ReportPopoverFactory,
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.popoverPosition = popoverPosition
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeReportPopoverViewController(
            coordinator: self,
            popoverPosition: popoverPosition)
        navigation.present(controller, animated: false)
    }
}
