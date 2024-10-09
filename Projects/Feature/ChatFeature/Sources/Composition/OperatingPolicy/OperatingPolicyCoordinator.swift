//
//  OperatingPolicyWebViewCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 9/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit
import WebKit

public protocol OperatingPolicyCoordinatorDelegate: AnyObject {
    func didFinishWebViewModal(childCoordinator: Coordinator)
}

public final class OperatingPolicyCoordinator: NSObject, Coordinator {
    public var navigation: Navigation
    public var factory: OperatingPolicyFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: OperatingPolicyCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: OperatingPolicyFactory,
        delegate: OperatingPolicyCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeOperatingPolicyWbViewController(coordinator: self)
        
        navigation.viewControllers = [controller]
    }
}




