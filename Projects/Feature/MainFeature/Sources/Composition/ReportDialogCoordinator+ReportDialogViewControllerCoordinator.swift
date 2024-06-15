//
//  ReportDialogCoordinator+ReportDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Foundation

extension ReportDialogCoordinator: ReportDialogViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didReport() {
        delegate?.didReport(childCoordinator: self)
    }
}
