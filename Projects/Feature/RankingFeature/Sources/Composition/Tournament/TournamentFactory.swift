//
//  TournamentFactory.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Domain
import FeatureDependency
import UIKit

public protocol TournamentFactory {
    func makeTournamentViewController(coordinator: TournamentViewControllerCoordinator) -> UIViewController
}

public struct TournamentFactoryImp: TournamentFactory {
    private (set) var category: String
    private (set) var participantList: [TournamentParticipantData]
    
    public func makeTournamentViewController(coordinator: TournamentViewControllerCoordinator) -> UIViewController {
        let viewModel = TournamentViewModel(
            category: category,
            participantList: participantList)
        let controller = TournamentViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
