//
//  VerificationCompleteDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import FeatureDependency
import UIKit

public protocol VerificationCompleteDialogCoordinatorDelegate: AnyObject {
    func didSelectOKButton(childCoordinator: Coordinator)
}

public final class VerificationCompleteDialogCoordinator: Coordinator {
    public var navigation: Navigation
    let factory: VerificationCompleteDialogFactory
    weak var delegate: VerificationCompleteDialogCoordinatorDelegate?

    public init(
        navigation: Navigation,
        factory: VerificationCompleteDialogFactory,
        delegate: VerificationCompleteDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeVerificationCompleteDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
