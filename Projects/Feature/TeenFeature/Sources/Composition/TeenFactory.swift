//
//  TeenFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public protocol TeenFactory {
    func makeTeenViewController() -> UIViewController
    func makeTeenDetailCoordinator(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator
}

public struct TeenFactoryImp: TeenFactory {
    public init() { }
    
    public func makeTeenViewController() -> UIViewController {
        let controller = TeenViewController()
        controller.navigationItem.title = "Teen"
        return controller
    }
    
    public func makeTeenDetailCoordinator(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider
    ) -> Coordinator {
        let factory = TeenDetailFactoryImp()
        return TeenDetailCoordinator(
            navigation: navigation,
            factory: factory,
            coordinatorProvider: coordinatorProvider)
    }
}
