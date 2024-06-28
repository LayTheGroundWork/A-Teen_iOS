//
//  TournamentFactory.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol TournamentFactory {
    func makeTournamentViewController(
        coordinator: TournamentViewControllerCoordinator,
        sector: String
    ) -> UIViewController
    
    func makeQuitTournamentDialogCoordinator(
        navigation: Navigation,
        delegate: QuitTournamentDialogCoordinatorDelegate
    ) -> Coordinator
}

public struct TournamentFactoryImp: TournamentFactory {
    let appContainer: AppContainer?

    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeTournamentViewController(
        coordinator: TournamentViewControllerCoordinator,
        sector: String
    ) -> UIViewController {
        let controller = TournamentViewController(
            coordinator: coordinator,
            sector: sector)
        return controller
    }
    
    public func makeQuitTournamentDialogCoordinator(
        navigation: Navigation,
        delegate: QuitTournamentDialogCoordinatorDelegate
    ) -> Coordinator {
        let factory = QuitTournamentDialogFactoryImp()
        return QuitTournamentDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate
        )
    }
}
