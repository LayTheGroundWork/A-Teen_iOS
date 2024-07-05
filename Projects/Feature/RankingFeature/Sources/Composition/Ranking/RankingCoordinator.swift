//
//  RankingCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public enum RankingFeatureViewNames {
    case ranking
    case tournament
    case rankingResult
}

public protocol RankingConfigTabbarStateDelegate: AnyObject {
    func configTabbarState(view: RankingFeatureViewNames)
}

public protocol RankingCoordinatorDelegate: RankingConfigTabbarStateDelegate { }

public final class RankingCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: RankingFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: RankingCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    var sector: String = ""
    
    public init(
        navigation: Navigation,
        factory: RankingFactory,
        delegate: RankingCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeRankingViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension RankingCoordinator: ParentCoordinator { }
