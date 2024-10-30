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
        category: String
    ) -> UIViewController
}

public struct TournamentFactoryImp: TournamentFactory {

    public init() { }
    
    public func makeTournamentViewController(
        coordinator: TournamentViewControllerCoordinator,
        category: String
    ) -> UIViewController {
        let controller = TournamentViewController(
            coordinator: coordinator,
            category: category)
        return controller
    }
}
