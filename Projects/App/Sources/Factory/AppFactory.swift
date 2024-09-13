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

protocol AppFactory {
    func makeMainTabCoordinator(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        factoryProvider: FactoryProvider
    ) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    
    func makeMainTabCoordinator(
        navigation: Navigation,
        delegate: MainTabCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        factoryProvider: FactoryProvider
    ) -> Coordinator {
        let factory = MainTabFactoryImp(
            coordinatorProvider: coordinatorProvider,
            factoryProvider: factoryProvider
        )
        
        return MainTabCoordinator(
            navigation: navigation,
            delegate: delegate,
            factory: factory,
            coordinatorProvider: coordinatorProvider,
            factoryProvider: factoryProvider)
    }
}
