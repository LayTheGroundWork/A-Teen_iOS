//
//  AppFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import Core
import MainTabFeature
import FeatureDependency
import UIKit

//TODO: - Use a protocol instead a concrete type
struct AppFactory {
    let appContainer: AppContainer?
    
    func makeMainTabCoordinator(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let factory = MainTabFactoryImp(appContainer: appContainer)
        return MainTabCoordinator(
            navigation: navigation,
            delegate: delegate, 
            factory: factory,
            coordinatorProvider: coordinatorProvider)
    }
}