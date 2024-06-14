//
//  NavigationImp+UINavigationControllerDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

extension NavigationImp: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let controller = navigationController
                .transitionCoordinator?
                .viewController(forKey: .from),
              !navigationController.viewControllers.contains(controller)
        else { return }
        
        guard let completion = backCompletions[controller] else { return }
        completion()
        backCompletions.removeValue(forKey: controller)
    }
}
