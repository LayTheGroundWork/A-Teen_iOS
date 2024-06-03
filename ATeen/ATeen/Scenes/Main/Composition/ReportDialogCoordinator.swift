//
//  ReportDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

protocol ReportDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didReport(childCoordinator: Coordinator)
}

final class ReportDialogCoordinator: Coordinator {
    var navigation: Navigation
    let factory: ReportDialogFactory
    weak var delegate: ReportDialogCoordinatorDelegate?

    init(
        navigation: Navigation,
        factory: ReportDialogFactory,
        delegate: ReportDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeReportDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
