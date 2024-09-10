//
//  QuestionsFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import FeatureDependency
import UIKit

public protocol QuestionsFactory {
    func makeQuestionsViewController(coordinator: QuestionsViewControllerCoordinator) -> UIViewController
    func makeQuestionsDialogCoordinator(
        delegate: QuestionsDialogCoordinatorDelegate
    ) -> Coordinator
    func makeQuestionDetailCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: QuestionDetailCoordinatorDelegate,
        index: Int
    ) -> Coordinator
}

public struct QuestionsFactoryImp: QuestionsFactory {
    let viewModel = QuestionsViewModel()
    
    public func makeQuestionsViewController(
        coordinator: QuestionsViewControllerCoordinator
    ) -> UIViewController {
        let controller = QuestionsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
    public func makeQuestionsDialogCoordinator(delegate: QuestionsDialogCoordinatorDelegate) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = QuestionsDialogFactoryImp(viewModel: viewModel)

        let coordinator = QuestionsDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
        return coordinator
    }
    
    public func makeQuestionDetailCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: QuestionDetailCoordinatorDelegate,
        index: Int
    ) -> Coordinator {
        let factory = QuestionDetailFactoryImp(
            question: viewModel.changeQuestionList[index],
            index: index)
        
        let coordinator = QuestionDetailCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
}
