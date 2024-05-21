//
//  NavigationImp+UIAdaptivePresentationControllerDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

extension NavigationImp: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        dismissNavigation?()
        dismissNavigation = nil
    }
}
