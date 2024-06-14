//
//  VerificationCompleteDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import UIKit

protocol VerificationCompleteDialogCoordinatorDelegate: AnyObject {
    func didSelectOKButton(childCoordinator: Coordinator)
}

final class VerificationCompleteDialogCoordinator: Coordinator {
    var navigation: Navigation
    let factory: VerificationCompleteDialogFactory
    weak var delegate: VerificationCompleteDialogCoordinatorDelegate?

    init(
        navigation: Navigation,
        factory: VerificationCompleteDialogFactory,
        delegate: VerificationCompleteDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeVerificationCompleteDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
