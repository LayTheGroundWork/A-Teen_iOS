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

public protocol RankingCoordinatorDelegate: AnyObject {
    func configTabbarState(view: RankingFeatureViewNames)
}

public final class RankingCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: RankingFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: RankingCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: RankingFactory,
        delegate: RankingCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeRankingViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension RankingCoordinator: ParentCoordinator { }
