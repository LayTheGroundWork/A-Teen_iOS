//
//  QuestionsCoordinator+QuestionsDialogCoordinatorDelegate.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension QuestionsCoordinator: QuestionsDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        
        questionsViewControllerDelegate?.didTabBackButtonFromQuestionsDialogViewController()
        이렇게 했음
        guard let factory = factory as? QuestionsFactoryImp else { return }
        didTabCell(index: factory.viewModel.changeQuestionList.endIndex - 1)
    }
}
