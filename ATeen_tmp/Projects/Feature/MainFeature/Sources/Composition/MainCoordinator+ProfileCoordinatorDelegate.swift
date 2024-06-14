//
//  MainCoordinator+ProfileCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import FeatureDependency

extension MainCoordinator: ProfileDetailCoordinatorDelegate,
                           ReportPopoverCoordinatorDelegate,
                           ReportDialogCoordinatorDelegate,
                           ReportCompleteDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func didSelectReportButton(childCoordinator: Coordinator) {
        didFinish(childCoordinator: childCoordinator)
        let reportDialogCoordinator = factory.makeReportDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(reportDialogCoordinator)
    }
    
    public func didReport(childCoordinator: Coordinator) {
        didFinish(childCoordinator: childCoordinator)
        let reportCompleteDialogCoordinator = factory.makeReportCompleteDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(reportCompleteDialogCoordinator)
    }
}
