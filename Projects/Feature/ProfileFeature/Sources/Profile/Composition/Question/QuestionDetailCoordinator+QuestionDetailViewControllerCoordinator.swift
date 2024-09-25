//
//  QuestionDetailCoordinator+QuestionDetailViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common

extension QuestionDetailCoordinator: QuestionDetailViewControllerCoordinator {
    public func didTabBackButton(question: Question, index: Int) {
        delegate?.didFinishQuestionDetailViewController(
            childCoordinator: self,
            question: question,
            index: index)
    }
}
