//
//  ReportCompleteDialogFactory.swift
//  ATeen
//
//  Created by phang on 6/3/24.
//

import UIKit

protocol ReportCompleteDialogFactory {
    func makeReportCompleteDialogViewController(
        coordinator: ReportCompleteDialogViewControllerCoordinator
    ) -> UIViewController
}

struct ReportCompleteDialogFactoryImp: ReportCompleteDialogFactory {
    func makeReportCompleteDialogViewController(
        coordinator: ReportCompleteDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = ReportCompleteDialogViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
