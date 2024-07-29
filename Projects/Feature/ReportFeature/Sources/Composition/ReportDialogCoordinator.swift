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
    func didReport()
}

public final class ReportDialogCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    let factory: ReportDialogFactory
    weak var delegate: ReportDialogCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider

    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: ReportDialogFactory,
        delegate: ReportDialogCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeReportDialogViewController(
            coordinator: self
        )
        
        navigation.pushViewController(controller, animated: false)
    }
}

extension ReportDialogCoordinator: ParentCoordinator { }
