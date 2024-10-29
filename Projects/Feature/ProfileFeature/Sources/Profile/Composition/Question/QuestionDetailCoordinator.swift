//
//  QuestionDetailCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Domain
import FeatureDependency
import UIKit

public protocol QuestionDetailCoordinatorDelegate: AnyObject {
    func didFinishQuestionDetailViewController(
        childCoordinator: Coordinator,
        question: QuestionData,
        index: Int
    )
}

public final class QuestionDetailCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: QuestionDetailFactory
    weak var delegate: QuestionDetailCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: QuestionDetailFactory,
        delegate: QuestionDetailCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeQuestionDetailViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension QuestionDetailCoordinator: ParentCoordinator { }

