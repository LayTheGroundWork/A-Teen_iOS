//
//  ReportDialogCoordinator+ReportDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Foundation

extension ReportDialogCoordinator: ReportDialogViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    func didReport() {
        delegate?.didReport(childCoordinator: self)
    }
}
