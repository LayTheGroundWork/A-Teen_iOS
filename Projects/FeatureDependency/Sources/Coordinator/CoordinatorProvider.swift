//
//  CoordinatorProvider.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

public protocol CoordinatorProvider {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator
    
    func makeAlbumCoordinator(
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator
    
    func makeAlertCoordinator(
        dialogType: AlertDialogType,
        delegate: AlertCoordinatorDelegate,
        dialogData: CustomDialog
    ) -> Coordinator
    
    func makePopoverCoordinator(
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate
    ) -> Coordinator
    
    func makeReportDialogCoordinator(
        navigation: Navigation,
        delegate: ReportDialogCoordinatorDelegate,
        childCoordinator: [Coordinator],
        dialogType: ReportDialogType
    ) -> Coordinator
}

public protocol ProfileDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public protocol AlbumCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public protocol AlertCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator, selectIndex: Int)
}

public protocol ReportPopoverCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didReport()
}

public protocol ReportDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func didReport()
}
