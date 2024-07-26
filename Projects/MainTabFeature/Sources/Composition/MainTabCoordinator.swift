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
    public let coordinatorProvider: CoordinatorProvider

    lazy var navigationTab: UITabBarController = {
        var navigationTab = UITabBarController()
        navigationTab = factory.makeMainTabController()
        return navigationTab
    }()
    
    public init(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        factory: MainTabFactory,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.delegate = delegate
        self.factory = factory
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        navigation.pushViewController(navigationTab, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(
            profileDelegate: self,
            mainDelegate: self,
            rankingDelegate: self,
            chatDelegate: self,
            coordinatorProvider: coordinatorProvider
        )
        let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
        childCoordinators.forEach { $0.start() }
        navigationTab.viewControllers = childNavigation
    }
}

extension MainTabCoordinator: ParentCoordinator { }
