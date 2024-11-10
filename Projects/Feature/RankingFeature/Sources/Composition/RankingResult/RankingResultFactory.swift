//
//  RankingResultFactory.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol RankingResultFactory {
    func makeRankingResultViewController(coordinator: RankingResultViewControllerCoordinator) -> UIViewController
}

public struct RankingResultFactoryImp: RankingResultFactory {
    private (set) var category: String
    private (set) var round: Int
    private (set) var tournamentNo: Int
    
    public func makeRankingResultViewController(coordinator: RankingResultViewControllerCoordinator) -> UIViewController {
        let viewModel = RankingResultViewModel(category: category, round: round, tournamentNo: tournamentNo)
        let controller = RankingResultViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
