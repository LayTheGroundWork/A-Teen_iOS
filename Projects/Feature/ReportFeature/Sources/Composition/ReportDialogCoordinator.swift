//
//  ReportDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Common
import FeatureDependency
import UIKit

public final class ReportDialogCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    let factory: ReportDialogFactory
    var dialogType: ReportDialogType
    weak var delegate: ReportDialogCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    public var rootViewController: UIViewController?
    
    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: ReportDialogFactory,
        dialogType: ReportDialogType,
        delegate: ReportDialogCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.dialogType = dialogType
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeReportDialogViewController(
            coordinator: self,
            dialogType: dialogType
        )
        self.navigation.pushViewController(controller, animated: false)
    }
}

extension ReportDialogCoordinator: ParentCoordinator { }
