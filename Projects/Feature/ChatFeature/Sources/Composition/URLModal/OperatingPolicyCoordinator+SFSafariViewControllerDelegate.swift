//
//  OperatingPolicyCoordinator+SFSafariViewControllerDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 9/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation
import SafariServices

extension OperatingPolicyWebViewCoordinator: SFSafariViewControllerDelegate {
    // 웹뷰 닫힐때 메모리해제
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
           delegate?.didFinishWebViewModal(childCoordinator: self)
       }
}
