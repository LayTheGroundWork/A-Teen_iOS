//
//  QuestionsCoordinator+QuestionDetailCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency

extension QuestionsCoordinator: QuestionDetailCoordinatorDelegate {
    public func didFinishQuestionDetailViewController(
        childCoordinator: Coordinator,
        question: Question,
        index: Int
    ) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.popViewController(animated: true)
        
        guard let factory = factory as? QuestionsFactoryImp else { return }
        factory.viewModel.changeQuestionList[index] = question
        
        questionsViewControllerDelegate?.didTabBackButtonFromQuestionsDialogViewController()
    }
}
