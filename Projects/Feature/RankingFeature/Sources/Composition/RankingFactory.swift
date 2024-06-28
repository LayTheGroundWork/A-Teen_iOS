//
//  RankingFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import FeatureDependency
import UIKit

public protocol RankingFactory {
    func makeRankingViewController(
        coordinator: RankingViewControllerCoordinator
    ) -> UIViewController
    
    func makeIntendToVoteDialogCoordinator(
        navigation: Navigation,
        delegate: IntendToVoteDialogCoordinatorDelegate,
        sector: String
    ) -> Coordinator
    
    func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        sector: String
    ) -> Coordinator
}

public struct RankingFactoryImp: RankingFactory {
    let appContainer: AppContainer?

    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeRankingViewController(
        coordinator: RankingViewControllerCoordinator
    ) -> UIViewController {
        let controller = RankingViewController(
            coordinator: coordinator)
        return controller
    }
    
    public func makeIntendToVoteDialogCoordinator(
        navigation: Navigation,
        delegate: IntendToVoteDialogCoordinatorDelegate,
        sector: String
    ) -> Coordinator {
        let factory = IntendToVoteDialogFactoryImp()
        return IntendToVoteDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            sector: sector
        )
    }
    
    public func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        sector: String
    ) -> Coordinator {
        let factory = TournamentFactoryImp(appContainer: appContainer)
        return TournamentCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            sector: sector
        )
    }
}
