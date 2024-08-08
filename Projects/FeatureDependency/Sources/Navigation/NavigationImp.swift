//
//  NavigationImp.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

public final class NavigationImp: NSObject {
    public var rootViewController: UINavigationController
    public var dismissNavigation: (() -> Void)?
    public var dismissNavigationFromAlbum: ((UIImage) -> Void)?
    
    public var backCompletions: [UIViewController: () -> Void] = [:]
    
    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()
        rootViewController.delegate = self
        rootViewController.presentationController?.delegate = self
    }
}

extension NavigationImp: Navigation {
    public var viewControllers: [UIViewController] {
        get {
            rootViewController.viewControllers
        }
        set {
            rootViewController.viewControllers = newValue
        }
    }
    
    public var navigationBar: UINavigationBar {
        rootViewController.navigationBar
    }

    public func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        rootViewController.present(viewControllerToPresent, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        rootViewController.dismiss(animated: animated)
    }
    
    public func popViewController(animated: Bool) {
        rootViewController.popViewController(animated: animated)
    }
    
    public func pushViewController(
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
