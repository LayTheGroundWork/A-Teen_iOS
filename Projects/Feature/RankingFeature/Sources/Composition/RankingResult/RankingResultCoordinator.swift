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
    
    public init(
        navigation: Navigation,
        factory: RankingResultFactory,
        delegate: RankingResultCoordinatorDelegate,
        withAnimation: Bool
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.withAnimation = withAnimation
    }
    
    public func start() {
        let controller = factory.makeRankingResultViewController(coordinator: self)
        navigation.pushViewController(controller, animated: withAnimation)
    }
}

extension RankingResultCoordinator: ParentCoordinator { }
