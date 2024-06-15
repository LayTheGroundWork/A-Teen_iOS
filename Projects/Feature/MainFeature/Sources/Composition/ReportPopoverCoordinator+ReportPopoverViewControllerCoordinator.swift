//
//  ReportPopoverCoordinator+ReportPopoverViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import Foundation

extension ReportPopoverCoordinator: ReportPopoverViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    func didSelectReportButton() {
        delegate?.didSelectReportButton(childCoordinator: self)
    }
}
