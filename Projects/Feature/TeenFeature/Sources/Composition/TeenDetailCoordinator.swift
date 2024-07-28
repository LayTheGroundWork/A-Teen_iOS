//
//  TeenDetailCoordinator.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol TeenDetailCoordinatorDelegate: AnyObject, TeenConfigTabbarStateDelegate {
    func didFinish(childCoordinator: Coordinator)
    func didSelectChattingButton()
}

public final class TeenDetailCoordinator: Coordinator {
    public var navigation: Navigation
    private var factory: TeenDetailFactory
    weak var delegate: TeenDetailCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    public let coordinatorProvider: CoordinatorProvider
    
    private let labelText: String
    
    public init(
        navigation: Navigation,
        factory: TeenDetailFactory,
        childCoordinators: [Coordinator],
        delegate: TeenDetailCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        labelText: String
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
        self.labelText = labelText
    }
    
    public func start() {
        let controller = factory.makeTeenDetailViewController(coordinator: self, labelText: labelText)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TeenDetailCoordinator: ParentCoordinator { }
