//
//  ProfileDetailCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import FeatureDependency
import UIKit

public final class ProfileDetailCoordinatorImp: Coordinator {
    public var navigation: Navigation
    public let coordinatorProvider: CoordinatorProvider
    private weak var delegate: ProfileDetailCoordinatorDelegate?
    public var childCoordinators: [Coordinator]
    public let frame: CGRect
    public let todayTeen: TodayTeen
    
    public init(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        delegate: ProfileDetailCoordinatorDelegate,
        childCoordinators: [Coordinator],
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        self.navigation = navigation
        self.coordinatorProvider = coordinatorProvider
        self.delegate = delegate
        self.childCoordinators = childCoordinators
        self.frame = frame
        self.todayTeen = todayTeen
    }
    
    public func start() {
        let controller = coordinatorProvider.makeProfileDetailViewController(
            coordinator: self,
            frame: frame,
            todayTeen: todayTeen)
        navigation.viewControllers = [controller]
    }
}

extension ProfileDetailCoordinatorImp: ProfileDetailViewControllerCoordinator {
    public func didFinishFlow() {
        delegate?.didFinish(childCoordinator: self)
    }
}

extension ProfileDetailCoordinatorImp: ParentCoordinator { }
