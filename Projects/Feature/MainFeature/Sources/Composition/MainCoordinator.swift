//
//  MainCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Common
import FeatureDependency
import UIKit

public protocol MainCoordinatorDelegate: AnyObject {
    func didSelectChattingButton()
    func didSelectAboutATeenCell(tag: TabTag)
}

public final class MainCoordinator: Coordinator {
    public var navigation: Navigation
    public let factory: MainFactory
    public var childCoordinators: [Coordinator] = []
    weak var delegate: MainCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        factory: MainFactory,
        delegate: MainCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeMainViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: ParentCoordinator { }
