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

final class MainTabCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: MainTabFactory
    private weak var delegate: MainTabCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        factory: MainTabFactory,
        delegate: MainTabCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let navigationTab = factory.makeMainTabController()
        navigation.pushViewController(navigationTab, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(delegate: self)
        let childNavigation = childCoordinators.map { $0.navigation.rootViewController }
        childCoordinators.forEach { $0.start() }
        navigationTab.viewControllers = childNavigation
    }

}

extension MainTabCoordinator: SettingsCoordinatorDelegate {
    func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
}
