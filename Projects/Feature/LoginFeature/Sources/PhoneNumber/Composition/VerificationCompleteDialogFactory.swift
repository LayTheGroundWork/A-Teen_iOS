//
//  VerificationCompleteDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import UIKit

public protocol VerificationCompleteDialogFactory {
    func makeVerificationCompleteDialogViewController(
        coordinator: VerificationCompleteDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct VerificationCompleteDialogFactoryImp: VerificationCompleteDialogFactory {
    public func makeVerificationCompleteDialogViewController(
        coordinator: VerificationCompleteDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = VerificationCompleteDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
