//
//  RankingCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public final class RankingCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: RankingFactory
    public var childCoordinators: [Coordinator] = []
    
    public init(
        navigation: Navigation,
        factory: RankingFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    public func start() {
        let controller = factory.makeRankingViewController(coordinator: self)
//        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension RankingCoordinator: ParentCoordinator { }
