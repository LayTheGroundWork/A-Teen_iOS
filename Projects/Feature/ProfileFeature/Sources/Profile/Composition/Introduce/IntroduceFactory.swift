//
//  IntroduceFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol IntroduceFactory {
    func makeIntroduceViewController(coordinator: IntroduceViewControllerCoordinator) -> UIViewController
}

public struct IntroduceFactoryImp: IntroduceFactory {
    public func makeIntroduceViewController(
        coordinator: IntroduceViewControllerCoordinator
    ) -> UIViewController {
        let viewModel = IntroduceViewModel()
        let controller = IntroduceViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}

