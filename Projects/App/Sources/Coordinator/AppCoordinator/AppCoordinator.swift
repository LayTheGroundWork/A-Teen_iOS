//
//  AppCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import MainTabFeature
import FeatureDependency
import UIKit

final class AppCoordinator: Coordinator {
    var navigation: Navigation
    var window: UIWindow?
    var factory: AppFactory?
    var childCoordinators: [Coordinator] = []
    private let coordinatorProvider = CoordinatorProviderImp()
    
    init(
        navigation: Navigation,
        window: UIWindow?,
        factory: AppFactory?
    ) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
    }
    
    func start() {
        configWindow()
        startMainTabCoordinator()
    }
    
    private func configWindow() {
        window?.rootViewController = navigation.rootViewController
        window?.makeKeyAndVisible()
    }

    private func startMainTabCoordinator() {
        let mainTabCoordinator = factory?.makeMainTabCoordinator(
            navigation: navigation,
            delegate: self, 
            coordinatorProvider: coordinatorProvider)
        addChildCoordinatorStart(mainTabCoordinator)
    }

    // MARK: - Private helpers
    private func clearCoordinatorsAndStart() {
        navigation.viewControllers = []
        clearAllChildsCoordinator()
        startMainTabCoordinator()
    }
}

// MARK: - MainTabCoordinatorDelegate
extension AppCoordinator: MainTabCoordinatorDelegate {
    func didFinish() {
        clearCoordinatorsAndStart()
    }
}

// MARK: - ParentCoordinator
extension AppCoordinator: ParentCoordinator { }
