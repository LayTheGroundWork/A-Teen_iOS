//
//  MainTabFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

struct MainTabFactory {
    let appContainer: AppContainer?
    
    func makeMainTabController() -> UITabBarController {
        let mainTabController = MainTabController()
        mainTabController.viewControllers = []
        mainTabController.title = "Main"
        return mainTabController
    }
    
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate) -> [Coordinator] {
        let homeCoordinator = makeHomeCoordinator()
        let myPostsCoordinator = makeMyPostsCoordinator()
        let communitiesCoordinator = makeCommunitiesCoordinator()
        let settingsCoordinator = makeSettingsCoordinator(delegate: delegate)
        
        return [homeCoordinator,
                myPostsCoordinator,
                communitiesCoordinator,
                settingsCoordinator]
    }
    
    private func makeHomeCoordinator() -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = HomeFactoryImp()
        return HomeCoordinator(
            navigation: navigation,
            factory: factory)
    }
    
    private func makeMyPostsCoordinator() -> Coordinator {
        let navigation = NavigationImp(rootViewController: UINavigationController())
        let factory = MyPostsFactoryImp()
        let mediator = MyPostsMediatorImp()
        return MyPostsCoordinator(
            navigation: navigation,
            factory: factory,
            mediator: mediator)
    }
    private func makeCommunitiesCoordinator() -> Coordinator {
        let factory = CommunitiesFactoryImp()
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return CommunitiesCoordinator(
            navigation: navigation,
            factory: factory)
    }
    
    private func makeSettingsCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = SettingsFactory(appContainer: appContainer)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        return SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }

}