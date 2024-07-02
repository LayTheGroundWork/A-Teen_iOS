//
//  QuitTournamentDialogFactory.swift
//  RankingFeature
//
//  Created by phang on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol QuitTournamentDialogFactory {
    func makeQuitTournamentDialogViewController(
        coordinator: QuitTournamentDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct QuitTournamentDialogFactoryImp: QuitTournamentDialogFactory {
    public func makeQuitTournamentDialogViewController(
        coordinator: QuitTournamentDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = QuitTournamentDialogViewController(
            coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
