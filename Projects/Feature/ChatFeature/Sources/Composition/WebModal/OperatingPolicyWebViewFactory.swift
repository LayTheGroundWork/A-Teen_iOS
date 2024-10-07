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

public protocol OperatingPolicyWebViewFactory {
    func makeOperatingPolicyWbViewController(coordinator: OpertaingPolicyModalViewControllerCoordinator) -> UIViewController?
}

public struct OperatingPolicyWebViewFactoryImp: OperatingPolicyWebViewFactory {
    public init() {}
    
    public func makeOperatingPolicyWbViewController(
        coordinator: OpertaingPolicyModalViewControllerCoordinator
    ) -> UIViewController? {
        let controller = OpertaingPolicyModalViewController(coordinator: coordinator)
        
        guard let url = URL(string: "https://www.google.com") else {
            print("Invalid URL for operating policy")
            return nil
        }
        controller.loadContent(url: url)
        
        return controller
    }
}
