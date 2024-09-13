//
//  ReportDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import Common
import UIKit

public protocol ReportDialogFactory {
    func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator,
        dialogType: ReportDialogType
    ) -> UIViewController
}

public struct ReportDialogFactoryImp: ReportDialogFactory {
    public init() { }
    
    public func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator,
        dialogType: ReportDialogType
    ) -> UIViewController {
        let controller = ReportDialogViewController(coordinator: coordinator, dialogType: dialogType)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
