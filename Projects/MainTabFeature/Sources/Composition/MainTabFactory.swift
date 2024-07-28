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
        profileDelegate: ProfileCoordinatorDelegate,
        mainDelegate: MainCoordinatorDelegate,
        rankingDelegate: RankingCoordinatorDelegate,
        teenDelegate: TeenCoordinatorDelegate,
        chatDelegate: ChatCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> [Coordinator] 
}

public struct MainTabFactoryImp: MainTabFactory {
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        coordinatorProvider: CoordinatorProvider
    ) {
        self.coordinatorProvider = coordinatorProvider
    }
    public func makeMainTabController() -> UITabBarController {
        let mainTabController = MainTabController()
        mainTabController.viewControllers = []
        return mainTabController
    }
    
    public func makeLoginCoordinator(delegate: LogInCoordinatorDelegate) -> Coordinator {
        let factory = LogInFactoryImp(coordinatorProvider: coordinatorProvider)
        let navigationController = UINavigationController()
        let navigation = NavigationImp(rootViewController: navigationController)
        
        return LogInCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider
        )
    }
    
    public func makeChildCoordinators(
        profileDelegate: ProfileCoordinatorDelegate,
        mainDelegate: MainCoordinatorDelegate,
        rankingDelegate: RankingCoordinatorDelegate,
        teenDelegate: TeenCoordinatorDelegate,
        chatDelegate: ChatCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> [Coordinator] {
        let mainCoordinator = makeMainCoordinator(delegate: mainDelegate,
                                                  coordinatorProvider: coordinatorProvider)
        let rankingCoordinator = makeRankingCoordinator(delegate: rankingDelegate)
        let teenCoordinator = makeTeenCoordinator(delegate: teenDelegate)
        let chatCoordinator = makeChatCoordinator()
        let profileCoordinator = makeProfileCoordinator(delegate: delegate)
        let teenCoordinator = makeTeenCoordinator()
        let chatCoordinator = makeChatCoordinator(delegate: chatDelegate)
        let profileCoordinator = makeProfileCoordinator(delegate: profileDelegate)
        
        return [mainCoordinator,
                rankingCoordinator,
                teenCoordinator,
                chatCoordinator,
                profileCoordinator]
    }
    
    private func makeMainCoordinator(
        delegate: MainCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = MainFactoryImp()
        return MainCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider)
    }
    
    private func makeRankingCoordinator(
        delegate: RankingCoordinatorDelegate
    ) -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = RankingFactoryImp()
        return RankingCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider
        )
    }
    
    private func makeTeenCoordinator(
        delegate: TeenCoordinatorDelegate
    ) -> Coordinator {
        let factory = TeenFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return TeenCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider)
    }
    
    private func makeChatCoordinator(delegate: ChatCoordinatorDelegate) -> Coordinator {
        let factory = ChatFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return ChatCoordinator(
            navigation: navigation,
            factory: factory, delegate: delegate)
    }
    
    private func makeProfileCoordinator(delegate: ProfileCoordinatorDelegate) -> Coordinator {
        let factory = ProfileFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return ProfileCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
}
