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

public protocol OperatingPolicyModalCoordinatorDelegate: AnyObject {
    func didFinishWebViewModal(childCoordinator: Coordinator)
}

public final class OperatingPolicyWebViewCoordinator: NSObject, Coordinator {
    public var navigation: Navigation
    public var factory: OperatingPolicyWebViewFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: OperatingPolicyModalCoordinatorDelegate?
    weak var webViewController: OpertaingPolicyModalViewController?
    
    public init(
        navigation: Navigation,
        factory: OperatingPolicyWebViewFactory,
        delegate: OperatingPolicyModalCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        guard let controller = factory.makeOperatingPolicyWbViewController(coordinator: self) as? OpertaingPolicyModalViewController else { return }
        webViewController = controller
        controller.webView?.navigationDelegate = self
        
        navigation.viewControllers = [controller]
    }
}




