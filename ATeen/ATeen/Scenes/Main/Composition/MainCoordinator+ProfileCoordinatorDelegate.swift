//
//  MainCoordinator+ProfileCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

extension MainCoordinator: ProfileDetailCoordinatorDelegate,
                           ReportPopoverCoordinatorDelegate,
                           ReportDialogCoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    func didSelectReportButton(childCoordinator: Coordinator) {
        didFinish(childCoordinator: childCoordinator)
        let reportDialogCoordinator = factory.makeReportDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(reportDialogCoordinator)
    }
}
