//
//  OperatingPolicyWebViewFactoryImp.swift
//  ChatFeature
//
//  Created by 김명현 on 9/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import SafariServices
import WebKit

public protocol OperatingPolicyFactory {
    func makeOperatingPolicyWbViewController(coordinator: OpertaingPolicyViewControllerCoordinator) -> UIViewController
}

public struct OperatingPolicyFactoryImp: OperatingPolicyFactory {
    public init() {}
    
    public func makeOperatingPolicyWbViewController(
        coordinator: OpertaingPolicyViewControllerCoordinator
    ) -> UIViewController {
        let controller = OpertaingPolicyViewController(coordinator: coordinator)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}
