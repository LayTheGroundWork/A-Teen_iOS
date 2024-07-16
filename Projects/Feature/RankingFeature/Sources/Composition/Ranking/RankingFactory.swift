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

    func makeRankingResultCoordinator(
        navigation: Navigation,
        delegate: RankingResultCoordinatorDelegate,
        withAnimation: Bool,
        sector: String,
        session: String
    ) -> Coordinator
    
    func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        sector: String
    ) -> Coordinator
}

public struct RankingFactoryImp: RankingFactory {

    public init() { }
    
    public func makeRankingViewController(
        coordinator: RankingViewControllerCoordinator
    ) -> UIViewController {
        let controller = RankingViewController(
            coordinator: coordinator)
        return controller
    }
    
    public func makeRankingResultCoordinator(
        navigation: Navigation,
        delegate: RankingResultCoordinatorDelegate,
        withAnimation: Bool,
        sector: String,
        session: String
    ) -> Coordinator {
        let factory = RankingResultFactoryImp()
        return RankingResultCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            withAnimation: withAnimation,
            sector: sector,
            session: session
        )
    }
    
    public func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        sector: String
    ) -> Coordinator {
        let factory = TournamentFactoryImp()
        return TournamentCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider,
            sector: sector
        )
    }
}
