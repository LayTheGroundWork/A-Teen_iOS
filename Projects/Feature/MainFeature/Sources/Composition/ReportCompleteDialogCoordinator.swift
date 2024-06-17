//
//  ReportCompleteDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import FeatureDependency
import UIKit

public protocol ReportCompleteDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class ReportCompleteDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: ReportCompleteDialogFactory
    weak var delegate: ReportCompleteDialogCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: ReportCompleteDialogFactory,
        delegate: ReportCompleteDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeReportCompleteDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
