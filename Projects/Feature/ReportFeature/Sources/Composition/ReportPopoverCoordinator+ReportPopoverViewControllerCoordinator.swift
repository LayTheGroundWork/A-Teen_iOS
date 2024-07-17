//
//  ReportPopoverCoordinator+ReportPopoverViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import FeatureDependency
import UIKit

extension ReportPopoverCoordinator: ReportPopoverViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelectReportButton() {
        let reportDialogCoordinator =
        factory.makeReportDialogCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self,
            coordinatorProvider: coordinatorProvider)
        
        addChildCoordinatorStart(reportDialogCoordinator)
    }
}
