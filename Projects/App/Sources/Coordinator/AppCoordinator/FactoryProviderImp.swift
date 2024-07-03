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
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = AlbumFactoryImp()
        return AlbumCoordinator(
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
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = AlertFactoryImp()
        return AlertCoordinator(
            dialogType: dialogType,
            navigation: navigation,
            factory: factory,
            dialogData: dialogData,
            delegate: delegate)
    }
}
