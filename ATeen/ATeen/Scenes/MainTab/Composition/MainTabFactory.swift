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
        mainTabController.viewControllers = [UIViewController()]
        mainTabController.title = "Main"
        return mainTabController
    }
    
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate) -> [Coordinator] {
        let settingsCoordinator = makeSettingsCoordinator(delegate: delegate)
        let communitiesCoordinator = makeCommunitiesCoordinator()
        
        return [communitiesCoordinator, settingsCoordinator]
    }
    
    private func makeSettingsCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = SettingsFactory(appContainer: appContainer)
        let navigation = UINavigationController()
        return SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
    }
    
    private func makeCommunitiesCoordinator() -> Coordinator {
        let factory = CommunitiesFactoryImp()
        let navigation = UINavigationController()
        return CommunitiesCoordinator(
            navigation: navigation,
            factory: factory)
    }
    

}
