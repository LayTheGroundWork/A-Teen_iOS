//
//  RankingFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import Domain
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
        category: String,
        round: Int,
        tournamentNo: Int
    ) -> Coordinator
    
    func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator
}

public struct RankingFactoryImp: RankingFactory {
    let viewModel = RankingViewModel()
    
    public init() { }
    
    public func makeRankingViewController(
        coordinator: RankingViewControllerCoordinator
    ) -> UIViewController {
        let controller = RankingViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
    public func makeRankingResultCoordinator(
        navigation: Navigation,
        delegate: RankingResultCoordinatorDelegate,
        withAnimation: Bool,
        category: String,
        round: Int,
        tournamentNo: Int
    ) -> Coordinator {
        let factory = RankingResultFactoryImp(
            category: category,
            round: round,
            tournamentNo: tournamentNo)
        return RankingResultCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            withAnimation: withAnimation)
    }
    
    public func makeTournamentCoordinator(
        navigation: Navigation,
        delegate: TournamentCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let factory = TournamentFactoryImp(
            category: viewModel.tournamentList[viewModel.tournamentIndex].category,
            thisWeekTournamentNumber: viewModel.tournamentList[viewModel.tournamentIndex].thisWeekTournamentNo,
            participantList: viewModel.thisWeekParticipantList)
        return TournamentCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider
        )
    }
}
