//
//  QuestionsFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol QuestionsFactory {
    func makeQuestionsViewController(coordinator: QuestionsViewControllerCoordinator) -> UIViewController
}

public struct QuestionsFactoryImp: QuestionsFactory {
    public func makeQuestionsViewController(
        coordinator: QuestionsViewControllerCoordinator
    ) -> UIViewController {
        let viewModel = QuestionsViewModel()
        let controller = QuestionsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
