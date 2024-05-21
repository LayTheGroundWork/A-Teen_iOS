//
//  AppCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigation: Navigation
    var window: UIWindow?
    var factory: AppFactory?
    var auth: SessionCheckAuth?
    
    var childCoordinators: [Coordinator] = []
    
    init(
        navigation: Navigation,
        window: UIWindow?,
        factory: AppFactory?,
        auth: SessionCheckAuth?
    ) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        configWindow()
        startSomeCoordinator()
    }
    
    private func configWindow() {
        window?.rootViewController = navigation.rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
        guard let auth = auth else { return }
        auth.isSessionActive ? startMainTabCoordinator() : startLoginCoordinator()
        
    }
    
    private func startLoginCoordinator() {
        let loginCoordinator = factory?.makeLogInCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(loginCoordinator)
    }
    
    private func startMainTabCoordinator() {
        let mainTabCoordinator = factory?.makeMainTabCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(mainTabCoordinator)
    }

    // MARK: - Private helpers
    private func clearCoordinatorsAndStart() {
        navigation.viewControllers = []
        clearAllChildsCoordinator()
        startSomeCoordinator()
    }
}

// MARK: - LogInCoordinatorDelegate
extension AppCoordinator: LogInCoordinatorDelegate {
    func didFinishLogin() {
        clearCoordinatorsAndStart()
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
