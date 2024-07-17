//
//  ReportDialogCoordinator+ReportDialogViewControllerCoordinator.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension ReportDialogCoordinator: ReportDialogViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didReport() {
        delegate?.didFinish(childCoordinator: self)
        delegate?.didReport()
    }
}
