//
//  SelectBirthCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import FeatureDependency
import Foundation

public protocol SelectBirthCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator, didSelectBirth: Bool)
}

public final class SelectBirthCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: SelectBirthFactory
    weak var delegate: SelectBirthCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    
    public init(
        navigation: Navigation,
        factory: SelectBirthFactory,
        delegate: SelectBirthCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSelectBirthViewController(coordinator: self)
        navigation.viewControllers = [controller]
    }
}

extension SelectBirthCoordinator: ParentCoordinator { }
