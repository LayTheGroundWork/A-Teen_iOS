//
//  IntendToVoteDialogFactory.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol IntendToVoteDialogFactory {
    func makeIntendToVoteDialogViewController(
        coordinator: IntendToVoteDialogCoordinator,
        sector: String
    ) -> UIViewController
}

public struct IntendToVoteDialogFactoryImp: IntendToVoteDialogFactory {
    public func makeIntendToVoteDialogViewController(
        coordinator: IntendToVoteDialogCoordinator,
        sector: String
    ) -> UIViewController {
        let controller = IntendToVoteDialogViewController(
            sector: sector,
            coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
