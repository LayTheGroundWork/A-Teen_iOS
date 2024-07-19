//
//  QuestionsCoordinator+QuestionsViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension QuestionsCoordinator: QuestionsViewControllerCoordinator {
    public func didTabBackButton() {
        delegate?.didFinishQuestionsViewController(childCoordinator: self)
    }
    
    public func didTabSelectQuestionButton() {
        let coordinator = factory.makeQuestionsDialogCoordinator(delegate: self)
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
