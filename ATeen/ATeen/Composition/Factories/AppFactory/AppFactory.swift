//
//  AppFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

//TODO: - Use a protocol instead a concrete type
struct AppFactory {
    let appContainer: AppContainer?
    
    func makeLogInCoordinator(navigation: Navigation,delegate: LogInCoordinatorDelegate
    ) -> Coordinator {
        let logInFactory = LogInFactoryImp(appContainer: appContainer)
        return LogInCoordinator(
            navigation: navigation,
            factory: logInFactory,
            delegate: delegate)
    }
    
    func makeMainTabCoordinator(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate
    ) -> Coordinator {
        let factory = MainTabFactoryImp(appContainer: appContainer)
        return MainTabCoordinator(
            navigation: navigation,
            delegate: delegate, 
            factory: factory)

    }
}
