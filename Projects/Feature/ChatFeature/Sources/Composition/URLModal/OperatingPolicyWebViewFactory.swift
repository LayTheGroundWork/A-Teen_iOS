//
//  makeOperatingPolicyWbViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 9/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import SafariServices

public protocol OperatingPolicyWebViewFactory {
    func makeOperatingPolicyWbViewController(coordinator: OperatingPolicyWebViewCoordinator) -> SFSafariViewController?
}

public struct OperatingPolicyWebViewFactoryImp: OperatingPolicyWebViewFactory {
    public init() {}
    
    public func makeOperatingPolicyWbViewController(coordinator: OperatingPolicyWebViewCoordinator) -> SFSafariViewController? {
        guard let url = URL(string: "https://velog.io/@kmh5038/posts") else {
            print("Invalid URL for operating policy")
            return nil
        }
        let controller = SFSafariViewController(url: url)
        
        return controller
    }
}
