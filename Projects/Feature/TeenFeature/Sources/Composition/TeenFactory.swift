//
//  TeenFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public protocol TeenFactory {
    func makeTeenViewController(
        coordinator: TeenViewControllerCoordinator
    ) -> UIViewController
    func makeTeenDetailCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TeenDetailCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        labelText: String
    ) -> Coordinator
}

public struct TeenFactoryImp: TeenFactory {
    let viewModel = TeenViewModel()
    
    public init() { }
    
    public func makeTeenViewController(
        coordinator: TeenViewControllerCoordinator
    ) -> UIViewController {
        let controller = TeenViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        controller.navigationItem.title = "Teen"
        return controller
    }
    
    public func makeTeenDetailCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: TeenDetailCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider,
        labelText: String
    ) -> Coordinator {
        let factory = TeenDetailFactoryImp()
        return TeenDetailCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            delegate: delegate,
            coordinatorProvider: coordinatorProvider,
            labelText: labelText)
    }
}
