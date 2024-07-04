//
//  TournamentCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol TournamentCoordinatorDelegate: RankingConfigTabbarStateDelegate {
    func quitTournament(childCoordinator: Coordinator)
    func finishTournament(
        childCoordinator: Coordinator,
        sector: String,
        session: String
    )
}

public final class TournamentCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: TournamentFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: TournamentCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    let sector: String
    
    public init(
        navigation: Navigation,
        factory: TournamentFactory,
        delegate: TournamentCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        sector: String
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
        self.sector = sector
    }
    
    public func start() {
        let controller = factory.makeTournamentViewController(
            coordinator: self,
            sector: sector)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TournamentCoordinator: ParentCoordinator { }
