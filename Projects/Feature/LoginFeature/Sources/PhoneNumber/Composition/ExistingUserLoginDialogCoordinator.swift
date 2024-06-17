//
//  ExistingUserLoginDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import FeatureDependency
import UIKit

public protocol ExistingUserLoginDialogCoordinatorDelegate: AnyObject {
    func navigateToMainViewController(childCoordinator: Coordinator)
}

public final class ExistingUserLoginDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: ExistingUserLoginDialogFactory
    weak var delegate: ExistingUserLoginDialogCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: ExistingUserLoginDialogFactory,
        delegate: ExistingUserLoginDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeExistingUserLoginDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
