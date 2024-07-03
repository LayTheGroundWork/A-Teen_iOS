//
//  CoordinatorProviderImp.swift
//  App
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import MainFeature

import UIKit

final class CoordinatorProviderImp: CoordinatorProvider {
    let factoryProvider = FactoryProviderImp()
}

// MARK: - ProfileDetail
extension CoordinatorProviderImp {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator {
        factoryProvider.makeProfileDetailCoordinator(
            delegate: delegate,
            frame: frame,
            todayTeen: todayTeen)
    }
}

extension CoordinatorProviderImp {
    func makeAlbumCoordinator(
        delegate: AlbumCoordinatorDelegate
    ) -> Coordinator {
        factoryProvider.makeAlbumCoordinator(delegate: delegate)
    }
}
