//
//  MainTabCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol MainTabCoordinatorDelegate: AnyObject {
    func didFinish()
}

protocol MainTabHiddenDelegate: AnyObject {
    func isHiddenTabbar()
}

final class MainTabCoordinator: Coordinator {
    var navigation: Navigation
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainTabCoordinatorDelegate?
    
    private let factory: MainTabFactory

    lazy var navigationTab: UITabBarController = {
        var navigationTab = UITabBarController()
        navigationTab = factory.makeMainTabController()
        return navigationTab
    }()
    
    init(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        factory: MainTabFactory
    ) {
        self.navigation = navigation
        self.delegate = delegate
        self.factory = factory
    }
    
    func start() {
        navigation.pushViewController(navigationTab, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(delegate: self, hiddenDelegate: self)
        let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
        childCoordinators.forEach { $0.start() }
        navigationTab.viewControllers = childNavigation
    }
}
