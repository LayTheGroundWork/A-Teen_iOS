//
//  CoordinatorProvider.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

public protocol CoordinatorProvider {
    func makeProfileDetailCoordinator(
        delegate: ProfileDetailCoordinatorDelegate,
        frame: CGRect,
        todayTeen: TodayTeen
    ) -> Coordinator
    
    func makeAlbumCoordinator(delegate: AlbumCoordinatorDelegate) -> Coordinator
}

public protocol ProfileDetailCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public protocol AlbumCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)

}
