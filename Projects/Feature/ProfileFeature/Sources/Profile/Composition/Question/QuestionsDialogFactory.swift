//
//  QuestionsDialogFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit

public protocol QuestionsDialogFactory {
    func makeQuestionsDialogViewController(
        coordinator: QuestionsDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct QuestionsDialogFactoryImp: QuestionsDialogFactory {
    var viewModel: QuestionsViewModel
    
    public init(viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
    }
    
    public func makeQuestionsDialogViewController(
        coordinator: QuestionsDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = QuestionsDialogViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
