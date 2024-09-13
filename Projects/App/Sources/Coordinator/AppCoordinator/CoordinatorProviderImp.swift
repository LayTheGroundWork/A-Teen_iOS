//
//  CoordinatorProviderImp.swift
//  App
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import MainFeature

import UIKit

final class CoordinatorProviderImp: CoordinatorProvider {
    let factoryProvider = FactoryProviderImp()
}

// MARK: - ProfileDetail
extension CoordinatorProviderImp {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        factoryProvider.makeProfileDetailCoordinator(
            delegate: delegate,
            frame: frame,
            todayTeen: todayTeen)
    }
}

// MARK: - MediaEditor
extension CoordinatorProviderImp {
    func makeAlbumCoordinator(
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator {
        factoryProvider.makeAlbumCoordinator(
            coordinatorProvider: self,
            delegate: delegate
        )
    }
}

// MARK: - Alert
extension CoordinatorProviderImp {
    func makeAlertCoordinator(
        dialogType: AlertDialogType,
        delegate: AlertCoordinatorDelegate,
        dialogData: CustomDialog
    ) -> Coordinator {
        factoryProvider.makeAlertCoordinator(
            dialogType: dialogType,
            delegate: delegate,
            dialogData: dialogData)
    }
}

// MARK: - Report
extension CoordinatorProviderImp {
    func makePopoverCoordinator(
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate
    ) -> Coordinator {
        factoryProvider.makePopoverCoordinator(
            popoverPosition: popoverPosition,
            delegate: delegate,
            coordinatorProvider: self)
    }
}

extension CoordinatorProviderImp {
    func makeReportDialogCoordinator(
        navigation: Navigation,
        delegate: ReportDialogCoordinatorDelegate,
        childCoordinator: [Coordinator],
        dialogType: ReportDialogType
    ) -> Coordinator {
        factoryProvider.makeReportDialogCoordinator(
            navigation: navigation,
            delegate: delegate,
            childCoordinator: childCoordinator,
            coordinatorProvider: self,
            dialogType: dialogType)
    }
}
