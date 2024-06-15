//
//  ExistingUserLoginDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import UIKit

public protocol ExistingUserLoginDialogFactory {
    func makeExistingUserLoginDialogViewController(
        coordinator: ExistingUserLoginDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct ExistingUserLoginDialogFactoryImp: ExistingUserLoginDialogFactory {
    public func makeExistingUserLoginDialogViewController(
        coordinator: ExistingUserLoginDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = ExistingUserLoginDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
