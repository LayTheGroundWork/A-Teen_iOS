//
//  VerificationCompleteDialogCoordinator+VerificationCompleteDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/8/24.
//

import Foundation

extension VerificationCompleteDialogCoordinator: VerificationCompleteDialogViewControllerCoordinator {
    public func didSelectOKButton() {
        delegate?.didSelectOKButton(childCoordinator: self)
    }
}
