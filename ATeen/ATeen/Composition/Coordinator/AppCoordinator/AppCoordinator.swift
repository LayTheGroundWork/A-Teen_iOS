//
//  AppCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    var factory: AppFactory?
    var auth: SessionCheckAuth?
    
    private var loginCoordinator: Coordinator?
    private var mainTabCoordinator: Coordinator?
    
    init(
        navigation: UINavigationController,
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
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
        guard let auth = auth else { return }
        auth.isSessionActive ? startMainTabCoordinator() : startLoginCoordinator()
        
    }
    
    private func startLoginCoordinator() {
        loginCoordinator = factory?.makeLogInCoordinator(
            navigation: navigation,
            delegate: self)
        loginCoordinator?.start()
    }
    
    private func startMainTabCoordinator() {
        mainTabCoordinator = factory?.makeMainTabCoordinator(
            navigation: navigation,
            delegate: self)
        mainTabCoordinator?.start()
    }
    
}

extension AppCoordinator: LogInCoordinatorDelegate {
    func didFinishLogin() {
        navigation.viewControllers = []
        loginCoordinator = nil
        startSomeCoordinator()
    }
}

extension AppCoordinator: MainTabCoordinatorDelegate {
    func didFinish() {
        navigation.viewControllers = []
        mainTabCoordinator = nil
        startSomeCoordinator()
    }
}
