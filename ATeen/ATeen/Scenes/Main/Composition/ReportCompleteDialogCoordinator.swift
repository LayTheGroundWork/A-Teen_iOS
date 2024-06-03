//
//  ReportCompleteDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

protocol ReportCompleteDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

final class ReportCompleteDialogCoordinator: Coordinator {
    var navigation: Navigation
    let factory: ReportCompleteDialogFactory
    weak var delegate: ReportCompleteDialogCoordinatorDelegate?

    init(
        navigation: Navigation,
        factory: ReportCompleteDialogFactory,
        delegate: ReportCompleteDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeReportCompleteDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
