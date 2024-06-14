//
//  Navigation.swift
//  ATeen
//
//  Created by Pozol on 5/21/24.
//

import UIKit

protocol Navigation {
    var rootViewController: UINavigationController { get }
    var viewControllers: [UIViewController] { get set }
    var navigationBar: UINavigationBar { get }
    func present(
        _ viewControllerToPresent: UIViewController,
        animated: Bool,
        completion: (() -> Void)?)
    func pushViewController(
        _ viewControllerToPresent: UIViewController,
        animated: Bool,
        backCompletion: (() -> Void)?
    )
    func dismiss(animated: Bool)
    func popViewController(animated: Bool)
    var dismissNavigation: (() -> Void)? { get set }
}

extension Navigation {
    func pushViewController(
        _ viewControllerToPresent: UIViewController,
        animated: Bool
    ) {
        pushViewController(viewControllerToPresent, animated: animated, backCompletion: nil)
    }
    
    func present(
        _ viewControllerToPresent: UIViewController,
        animated: Bool
    ) {
        present(viewControllerToPresent, animated: animated, completion: nil)
    }
}
