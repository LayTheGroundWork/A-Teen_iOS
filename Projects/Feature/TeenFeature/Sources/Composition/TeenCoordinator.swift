//
//  TeenCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Common
import FeatureDependency
import UIKit

public enum TeenFeatureViewNames {
    case teen
    case teenDetail
}

public protocol TeenCoordinatorDelegate: AnyObject, TeenConfigTabbarStateDelegate {
    func didSelectChattingButton()
}

public protocol TeenConfigTabbarStateDelegate: AnyObject {
    func configTabbarState(view: TeenFeatureViewNames)
}

public final class TeenCoordinator: Coordinator {
    public var navigation: Navigation
    var factory: TeenFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: TeenCoordinatorDelegate?
    public let coordinatorProvider: CoordinatorProvider
    
    public init(
        navigation: Navigation,
        factory: TeenFactory,
        delegate: TeenCoordinatorDelegate,
        coordinatorProvider: CoordinatorProvider
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
        self.coordinatorProvider = coordinatorProvider
    }
    
    public func start() {
        let controller = factory.makeTeenViewController(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}

extension TeenCoordinator: ParentCoordinator { }
