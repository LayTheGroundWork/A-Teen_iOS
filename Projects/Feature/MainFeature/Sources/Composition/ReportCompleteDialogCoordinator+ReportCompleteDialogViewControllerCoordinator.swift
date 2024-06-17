//
//  ReportCompleteDialogCoordinator+ReportCompleteDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Foundation

extension ReportCompleteDialogCoordinator: ReportCompleteDialogViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
