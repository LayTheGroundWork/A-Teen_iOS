//
//  IntendToVoteDialogCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol IntendToVoteDialogCoordinatorDelegate: AnyObject {
    func quitDialog(childCoordinator: Coordinator)
    func didTapParticipateInVote(childCoordinator: Coordinator, sector: String)
}

public final class IntendToVoteDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: IntendToVoteDialogFactory
    weak var delegate: IntendToVoteDialogCoordinatorDelegate?
    let sector: String
    
    public init(
        navigation: Navigation,
        factory: IntendToVoteDialogFactory,
        delegate: IntendToVoteDialogCoordinatorDelegate,
        sector: String
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.sector = sector
    }
    
    public func start() {
        let controller = factory.makeIntendToVoteDialogViewController(
            coordinator: self,
            sector: sector)
        navigation.present(controller, animated: false)
    }
}
