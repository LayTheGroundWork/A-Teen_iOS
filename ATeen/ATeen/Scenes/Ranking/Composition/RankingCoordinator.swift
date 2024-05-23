//
//  RankingCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

final class RankingCoordinator: Coordinator {
    var navigation: Navigation
    let factory: RankingFactory
    
    init(
        navigation: Navigation,
        factory: RankingFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeRankingViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

