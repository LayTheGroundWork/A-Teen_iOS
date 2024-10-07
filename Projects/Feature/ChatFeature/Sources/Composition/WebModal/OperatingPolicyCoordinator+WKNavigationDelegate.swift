//
//  OperatingPolicyCoordinator+WKNavigationDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import WebKit

extension OperatingPolicyWebViewCoordinator: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewController?.activityIndicator.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webViewController?.activityIndicator.stopAnimating()
    }
}
