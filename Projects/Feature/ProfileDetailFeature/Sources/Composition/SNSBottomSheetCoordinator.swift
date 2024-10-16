//
//  SNSBottomSheetCoordinator.swift
//  ProfileDetailFeature
//
//  Created by 최동호 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol SNSBottomSheetCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class SNSBottomSheetCoordinator: Coordinator {
    public var navigation: Navigation
    public var factory: SNSBottomSheetFactory
    public var childCoordinators: [Coordinator]
    public var contentViewController: UIViewController
    weak var delegate: SNSBottomSheetCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: SNSBottomSheetFactory,
        childCoordinators: [Coordinator],
        contentViewController: UIViewController,
        delegate: SNSBottomSheetCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.contentViewController = contentViewController
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSNSBottomSheetViewController(
            contentViewController: contentViewController)

        navigation.present(controller, animated: true)
    }
}

extension SNSBottomSheetCoordinator: ParentCoordinator { }
