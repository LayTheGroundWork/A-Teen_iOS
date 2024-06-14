//
//  MainTabFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

protocol MainTabFactory {
    func makeMainTabController() -> UITabBarController
    func makeLoginCoordinator(
        delegate: LogInCoordinatorDelegate
    ) -> Coordinator
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate, mainDelegate: MainCoordinatorDelegate) -> [Coordinator]
}

struct MainTabFactoryImp: MainTabFactory {
    let appContainer: AppContainer?
    
    func makeMainTabController() -> UITabBarController {
        let mainTabController = MainTabController()
        mainTabController.viewControllers = []
        return mainTabController
    }
    
    func makeLoginCoordinator(delegate: LogInCoordinatorDelegate) -> Coordinator {
        let factory = LogInFactoryImp(appContainer: appContainer)
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return LogInCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
    
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate, mainDelegate: MainCoordinatorDelegate) -> [Coordinator] {
        let mainCoordinator = makeMainCoordinator(delegate: mainDelegate)
        let rankingCoordinator = makeRankingCoordinator()
        let teenCoordinator = makeTeenCoordinator()
        let chatCoordinator = makeChatCoordinator()
        let profileCoordinator = makeProfileCoordinator(delegate: delegate)
        
        return [mainCoordinator,
                rankingCoordinator,
                teenCoordinator,
                chatCoordinator,
                profileCoordinator]
    }
    
    private func makeMainCoordinator(delegate: MainCoordinatorDelegate) -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = MainFactoryImp(appContainer: appContainer)
        return MainCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
    
    private func makeRankingCoordinator() -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = RankingFactoryImp()
        return RankingCoordinator(
            navigation: navigation,
            factory: factory)
    }
    private func makeTeenCoordinator() -> Coordinator {
        let factory = TeenFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return TeenCoordinator(
            navigation: navigation,
            factory: factory)
    }
    
    private func makeChatCoordinator() -> Coordinator {
        let factory = ChatFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return ChatCoordinator(
            navigation: navigation,
            factory: factory)
    }
    
    private func makeProfileCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = ProfileFactoryImp(appContainer: appContainer)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return ProfileCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
}
