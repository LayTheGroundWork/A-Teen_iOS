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
        print("123")
    }
    
    public func didReport() {
        delegate?.didReport()
    }
}
