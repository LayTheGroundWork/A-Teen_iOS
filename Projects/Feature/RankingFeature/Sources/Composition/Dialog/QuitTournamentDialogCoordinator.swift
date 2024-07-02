//
//  QuitTournamentDialogCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol QuitTournamentDialogCoordinatorDelegate: AnyObject {
    func quitDialog(childCoordinator: Coordinator)
    func endTournament(childCoordinator: Coordinator)
}

public final class QuitTournamentDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: QuitTournamentDialogFactory
    weak var delegate: QuitTournamentDialogCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: QuitTournamentDialogFactory,
        delegate: QuitTournamentDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeQuitTournamentDialogViewController(
            coordinator: self)
        navigation.present(controller, animated: false)
    }
}
