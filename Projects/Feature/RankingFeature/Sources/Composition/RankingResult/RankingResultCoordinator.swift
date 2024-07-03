//
//  RankingResultCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol RankingResultCoordinatorDelegate: RankingConfigTabbarStateDelegate {
    func didFinish(childCoordinator: Coordinator)
}

public final class RankingResultCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: RankingResultFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: RankingResultCoordinatorDelegate?
    let withAnimation: Bool
    let sector: String
    let session: String
    
    public init(
        navigation: Navigation,
        factory: RankingResultFactory,
        delegate: RankingResultCoordinatorDelegate,
        withAnimation: Bool,
        sector: String,
        session: String
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.withAnimation = withAnimation
        self.sector = sector
        self.session = session
    }
    
    public func start() {
        let controller = factory.makeRankingResultViewController(
            coordinator: self,
            withAnimation: withAnimation,
            sector: sector,
            session: session)
        navigation.pushViewController(controller, animated: withAnimation)
    }
}

extension RankingResultCoordinator: ParentCoordinator { }
