//
//  ReportPopoverFactory.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

public protocol ReportPopoverFactory {
    func makeReportPopoverViewController(
        coordinator: ReportPopoverCoordinator,
        popoverPosition: CGRect
    ) -> UIViewController
}

public struct ReportPopoverFactoryImp: ReportPopoverFactory {
    public init() { }
    
    public func makeReportPopoverViewController(
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
