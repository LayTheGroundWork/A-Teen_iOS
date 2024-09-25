//
//  makeOperatingPolicyWbViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 9/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import SafariServices
import WebKit

public protocol OperatingPolicyWebViewFactory {
    func makeOperatingPolicyWbViewController(coordinator: OperatingPolicyWebViewCoordinator) -> UIViewController?
}

public struct OperatingPolicyWebViewFactoryImp: OperatingPolicyWebViewFactory {
    public init() {}
    
    public func makeOperatingPolicyWbViewController(coordinator: OperatingPolicyWebViewCoordinator) -> UIViewController? {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        let controller = UIViewController()
        controller.view = webView
        
        guard let url = URL(string: "https://velog.io/@kmh5038/posts") else {
            print("Invalid URL for operating policy")
            return nil
        }
        
        webView.load(URLRequest(url: url))
        
        return controller
    }
}
