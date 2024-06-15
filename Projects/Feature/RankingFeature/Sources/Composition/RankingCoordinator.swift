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
    let factory: RankingFactory
    
    public init(
        navigation: Navigation,
        factory: RankingFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    public func start() {
        let controller = factory.makeRankingViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

