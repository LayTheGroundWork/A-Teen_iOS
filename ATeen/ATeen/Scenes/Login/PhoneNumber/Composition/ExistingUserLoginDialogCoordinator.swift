//
//  ExistingUserLoginDialogCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import UIKit

protocol ExistingUserLoginDialogCoordinatorDelegate: AnyObject {
    //
}

final class ExistingUserLoginDialogCoordinator: Coordinator {
    var navigation: Navigation
    let factory: ExistingUserLoginDialogFactory
    weak var delegate: ExistingUserLoginDialogCoordinatorDelegate?

    init(
        navigation: Navigation,
        factory: ExistingUserLoginDialogFactory,
        delegate: ExistingUserLoginDialogCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeExistingUserLoginDialogViewController(
            coordinator: self
        )
        navigation.present(controller, animated: false)
    }
}
