//
//  ReportDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import FeatureDependency
import UIKit

public protocol ReportDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didReport(childCoordinator: Coordinator)
}

public final class ReportDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: ReportDialogFactory
    weak var delegate: ReportDialogCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: ReportDialogFactory,
        delegate: ReportDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeReportDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
