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
        print("여기 얼럿")
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
