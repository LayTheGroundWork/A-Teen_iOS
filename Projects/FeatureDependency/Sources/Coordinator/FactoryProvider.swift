//
//  FactoryProvider.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

public protocol FactoryProvider {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator
    
    func makeAlbumCoordinator(
        coordinatorProvider: CoordinatorProvider,
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator
    
    func makeAlertCoordinator(
        dialogType: AlertDialogType,
        delegate: AlertCoordinatorDelegate,
        dialogData: CustomDialog
    ) -> Coordinator
    
    func makePopoverCoordinator(
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator
}
