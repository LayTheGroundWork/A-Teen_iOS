//
//  FactoryProviderImp.swift
//  App
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import AlertFeature
import ProfileDetailFeature
import ReportFeature
import MediaEditorFeature
import UIKit

final class FactoryProviderImp: FactoryProvider {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = ProfileDetailFactoryImp(frame: frame, todayTeen: todayTeen)
        return ProfileDetailCoordinatorImp(
            factory: factory,
            frame: frame,
            todayTeen: todayTeen,
            navigation: navigation,
            childCoordinators: [],
            delegate: delegate)
    }
    
    func makeAlbumCoordinator(
        coordinatorProvider: CoordinatorProvider,
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = AlbumFactoryImp()
        return AlbumCoordinator(
            coordinatorProvider: coordinatorProvider,
            factory: factory,
            navigation: navigation,
            childCoordinators: [],
            delegate: delegate)
    }
    
    func makeAlertCoordinator(
        dialogType: AlertDialogType,
        delegate: AlertCoordinatorDelegate,
        dialogData: CustomDialog
    ) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = AlertFactoryImp()
        return AlertCoordinator(
            dialogType: dialogType,
            navigation: navigation,
            factory: factory,
            dialogData: dialogData,
            delegate: delegate)
    }
    
    func makePopoverCoordinator(
        popoverPosition: CGRect,
        delegate: ReportPopoverCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = ReportPopoverFactoryImp()
        return ReportPopoverCoordinator(
            navigation: navigation,
            childCoordinators: [],
            factory: factory,
            popoverPosition: popoverPosition,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider
        )
    }
    
    func makeReportDialogCoordinator(
        navigation: Navigation,
        delegate: ReportDialogCoordinatorDelegate,
        childCoordinator: [Coordinator],
        coordinatorProvider: CoordinatorProvider,
        dialogType: ReportDialogType
    ) -> Coordinator {
        let factory = ReportDialogFactoryImp()
        return ReportDialogCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinator,
            factory: factory,
            dialogType: dialogType,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider
        )
    }
}
