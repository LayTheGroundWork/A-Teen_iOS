//
//  ReportCompleteDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

public protocol ReportCompleteDialogFactory {
    func makeReportCompleteDialogViewController(
        coordinator: ReportCompleteDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct ReportCompleteDialogFactoryImp: ReportCompleteDialogFactory {
    public func makeReportCompleteDialogViewController(
        coordinator: ReportCompleteDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = ReportCompleteDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
