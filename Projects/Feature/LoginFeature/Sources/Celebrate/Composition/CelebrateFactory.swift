//
//  CelebrateFactory.swift
//  LoginFeature
//
//  Created by 최동호 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol CelebrateFactory {
    func makeCelebrateViewController(
        coordinator: CelebrateViewControllerCoordinator
    ) -> UIViewController
}

public struct CelebrateFactoryImp: CelebrateFactory {
    public func makeCelebrateViewController(
        coordinator: CelebrateViewControllerCoordinator
    ) -> UIViewController {
        return CelebrateViewController(coordinator: coordinator)
    }
}
