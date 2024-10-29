//
//  QuestionsCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import FeatureDependency
import UIKit

public protocol QuestionsCoordinatorDelegate: AnyObject {
    func didFinishQuestionsViewController(childCoordinator: Coordinator, user: MyPageData)
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class QuestionsCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: QuestionsFactory
    weak var delegate: QuestionsCoordinatorDelegate?
    weak var questionsViewControllerDelegate: QuestionsViewControllerDelegate?
    public var childCoordinators: [Coordinator]
    
    public init(
        navigation: Navigation,
        factory: QuestionsFactory,
        delegate: QuestionsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.childCoordinators = childCoordinators
    }
    
    public func start() {
        let controller = factory.makeQuestionsViewController(coordinator: self)
        questionsViewControllerDelegate = controller as? any QuestionsViewControllerDelegate
        navigation.pushViewController(controller, animated: true)
    }
}

extension QuestionsCoordinator: ParentCoordinator { }
