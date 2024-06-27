//
//  MainTabFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import FeatureDependency
import ChatFeature
import ProfileFeature
import MainFeature
import LoginFeature
import RankingFeature
import TeenFeature
import UIKit

public protocol MainTabFactory {
    func makeMainTabController() -> UITabBarController
    func makeLoginCoordinator(
        delegate: LogInCoordinatorDelegate
    ) -> Coordinator
    func makeChildCoordinators(
        delegate: SettingsCoordinatorDelegate,
        mainDelegate: MainCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> [Coordinator]
}

public struct MainTabFactoryImp: MainTabFactory {
    let appContainer: AppContainer?
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeMainTabController() -> UITabBarController {
        let mainTabController = MainTabController()
        mainTabController.viewControllers = []
        return mainTabController
    }
    
    public func makeLoginCoordinator(delegate: LogInCoordinatorDelegate) -> Coordinator {
        let factory = LogInFactoryImp(appContainer: appContainer)
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return LogInCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
    
    public func makeChildCoordinators(
        delegate: SettingsCoordinatorDelegate,
        mainDelegate: MainCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> [Coordinator] {
        let mainCoordinator = makeMainCoordinator(delegate: mainDelegate, coordinatorProvider: coordinatorProvider)
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
    
    private func makeMainCoordinator(delegate: MainCoordinatorDelegate, coordinatorProvider: CoordinatorProvider) -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = MainFactoryImp(appContainer: appContainer)
        return MainCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider)
    }
    
    private func makeRankingCoordinator() -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = RankingFactoryImp(appContainer: appContainer)
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
