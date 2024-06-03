//
//  ReportPopoverCoordinator.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

protocol ReportPopoverCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didSelectReportButton(childCoordinator: Coordinator)
}

final class ReportPopoverCoordinator: Coordinator {
    var navigation: Navigation
    let factory: ReportPopoverFactory
    let popoverPosition: CGRect
    weak var delegate: ReportPopoverCoordinatorDelegate?

    init(
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
    
    func start() {
        let controller = factory.makeReportPopoverViewController(
            coordinator: self,
            popoverPosition: popoverPosition)
        navigation.present(controller, animated: false)
    }
}
