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
    func makeRankingResultViewController(
        coordinator: RankingResultViewControllerCoordinator,
        withAnimation: Bool,
        sector: String,
        session: String
    ) -> UIViewController
}

public struct RankingResultFactoryImp: RankingResultFactory {
    public init() { }
    
    public func makeRankingResultViewController(
        coordinator: RankingResultViewControllerCoordinator,
        withAnimation: Bool,
        sector: String,
        session: String
    ) -> UIViewController {
        let controller = RankingResultViewController(
            coordinator: coordinator,
            sector: sector,
            session: session)
        return controller
    }
}
