//
//  ReportDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

protocol ReportDialogFactory {
    func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator
    ) -> UIViewController
}

struct ReportDialogFactoryImp: ReportDialogFactory {
    func makeReportDialogViewController(
        coordinator: ReportDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = ReportDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
