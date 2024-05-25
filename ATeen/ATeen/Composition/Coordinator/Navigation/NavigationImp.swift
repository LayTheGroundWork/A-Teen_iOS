//
//  NavigationImp.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

final class NavigationImp: NSObject {
    var rootViewController: UINavigationController
    var dismissNavigation: (() -> Void)?
    
    var backCompletions: [UIViewController: () -> Void] = [:]
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()
        rootViewController.delegate = self
        rootViewController.presentationController?.delegate = self
    }
}

extension NavigationImp: Navigation {
    var viewControllers: [UIViewController] {
        get {
            rootViewController.viewControllers
        }
        set {
            rootViewController.viewControllers = newValue
        }
    }
    
    var navigationBar: UINavigationBar {
        rootViewController.navigationBar
    }

    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        rootViewController.present(viewControllerToPresent, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        rootViewController.dismiss(animated: animated)
    }
    
    func pushViewController(
        _ viewControllerToPresent: UIViewController,
        animated: Bool,
        backCompletion: (() -> Void)?
    ) {
        if let backCompletion = backCompletion {
            backCompletions[viewControllerToPresent] = backCompletion
        }
        rootViewController.pushViewController(viewControllerToPresent, animated: animated)
    }
}
