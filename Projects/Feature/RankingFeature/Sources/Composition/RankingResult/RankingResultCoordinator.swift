//
//  RankingResultCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol RankingResultCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
    func configTabbarStateInRankingResult(view: RankingFeatureViewNames)
}

public final class RankingResultCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: RankingResultFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: RankingResultCoordinatorDelegate?
    let sector: String
    
    public init(
        navigation: Navigation,
        factory: RankingResultFactory,
        delegate: RankingResultCoordinatorDelegate,
        sector: String
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.sector = sector
    }
    
    public func start() {
        let controller = factory.makeRankingResultViewController(
            coordinator: self,
            sector: sector)
        navigation.pushViewController(controller, animated: true)
    }
}

extension RankingResultCoordinator: ParentCoordinator { }
