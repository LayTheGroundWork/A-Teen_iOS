//
//  ReportPopoverCoordinator.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import FeatureDependency
import UIKit

public final class ReportPopoverCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    let factory: ReportPopoverFactory
    let popoverPosition: CGRect
    weak var delegate: ReportPopoverCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: ReportPopoverFactory,
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.popoverPosition = popoverPosition
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeReportPopoverViewController(
            coordinator: self,
            popoverPosition: popoverPosition)
        navigation.viewControllers = [controller]
    }
}

extension ReportPopoverCoordinator: ParentCoordinator { }
