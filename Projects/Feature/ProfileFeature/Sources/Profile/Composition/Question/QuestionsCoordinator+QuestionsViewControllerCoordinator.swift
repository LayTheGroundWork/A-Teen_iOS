//
//  QuestionsCoordinator+QuestionsViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency

extension QuestionsCoordinator: QuestionsViewControllerCoordinator {
    public func didTabBackButton(user: MyPageData) {
        delegate?.didFinishQuestionsViewController(childCoordinator: self, user: user)
    }
    
    public func didTabCell(index: Int) {
        let coordinator = factory.makeQuestionDetailCoordinator(
            navigation: navigation,
            childCoordinators: childCoordinators,
            delegate: self,
            index: index)
        addChildCoordinatorStart(coordinator)
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
