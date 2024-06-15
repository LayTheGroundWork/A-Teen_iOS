//
//  MainTabCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public protocol MainTabCoordinatorDelegate: AnyObject {
    func didFinish()
}

public final class MainTabCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator] = []
    weak var delegate: MainTabCoordinatorDelegate?
    
    let factory: MainTabFactory

    lazy var navigationTab: UITabBarController = {
        var navigationTab = UITabBarController()
        navigationTab = factory.makeMainTabController()
        return navigationTab
    }()
    
    public init(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        factory: MainTabFactory
    ) {
        self.navigation = navigation
        self.delegate = delegate
        self.factory = factory
    }
    
    public func start() {
        navigation.pushViewController(navigationTab, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(delegate: self, mainDelegate: self)
        let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
        childCoordinators.forEach { $0.start() }
        navigationTab.viewControllers = childNavigation
    }
}

extension MainTabCoordinator: ParentCoordinator { }
