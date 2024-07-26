//
//  QuestionsDialogCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol QuestionsDialogCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class QuestionsDialogCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: QuestionsDialogFactory
    weak var delegate: QuestionsDialogCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    
    public init(
        navigation: Navigation,
        factory: QuestionsDialogFactory,
        delegate: QuestionsDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeQuestionsDialogViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}
