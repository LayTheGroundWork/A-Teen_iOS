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
        sector: String
    ) -> UIViewController
}

public struct RankingResultFactoryImp: RankingResultFactory {
    let appContainer: AppContainer?

    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeRankingResultViewController(
        coordinator: RankingResultViewControllerCoordinator,
        sector: String
    ) -> UIViewController {
        let controller = RankingResultViewController(
            coordinator: coordinator,
            sector: sector)
        return controller
    }
}
