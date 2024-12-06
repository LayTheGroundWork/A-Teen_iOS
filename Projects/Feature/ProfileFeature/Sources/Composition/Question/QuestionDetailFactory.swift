//
//  QuestionDetailFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import FeatureDependency
import UIKit

public protocol QuestionDetailFactory {
    func makeQuestionDetailViewController(
        coordinator: QuestionDetailViewControllerCoordinator
    ) -> UIViewController
}

public struct QuestionDetailFactoryImp: QuestionDetailFactory {
    private(set) var question: QuestionData
    private(set) var index: Int
    
    public init(
        question: QuestionData,
        index: Int
    ) {
        self.question = question
        self.index = index
    }
    
    public func makeQuestionDetailViewController(
        coordinator: QuestionDetailViewControllerCoordinator
    ) -> UIViewController {
        let controller = QuestionDetailViewController(
            coordinator: coordinator,
            question: question,
            index: index)
        return controller
    }
}
