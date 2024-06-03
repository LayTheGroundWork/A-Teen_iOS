//
//  ReportPopoverFactory.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

protocol ReportPopoverFactory {
    func makeReportPopoverViewController(
        coordinator: ReportPopoverCoordinator,
        popoverPosition: CGRect
    ) -> UIViewController
}

struct ReportPopoverFactoryImp: ReportPopoverFactory {
    
    func makeReportPopoverViewController(
        coordinator: ReportPopoverCoordinator,
        popoverPosition: CGRect
    ) -> UIViewController {
        let controller = ReportPopoverViewController(
            coordinator: coordinator,
            popoverPosition: popoverPosition)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
