//
//  ReportDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

public protocol ReportDialogFactory {
    func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct ReportDialogFactoryImp: ReportDialogFactory {
    public init() { }
    
    public func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = ReportDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
