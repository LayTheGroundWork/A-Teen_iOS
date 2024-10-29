//
//  ProfileDetailCoordinatorImp.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import Domain
import FeatureDependency
import UIKit

public final class ProfileDetailCoordinatorImp: ProfileDetailCoordinator {
    public let factory: ProfileDetailFactory
    public let frame: CGRect
    public let todayTeen: UserData
    public var navigation: Navigation
    public var childCoordinators: [Coordinator]
    
    weak var delegate: ProfileDetailCoordinatorDelegate?
    
    public init(
        factory: ProfileDetailFactory,
        frame: CGRect,
        todayTeen: UserData,
        navigation: Navigation,
        childCoordinators: [Coordinator],
        delegate: ProfileDetailCoordinatorDelegate
    ) {
        self.factory = factory
        self.frame = frame
        self.todayTeen = todayTeen
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeProfileDetailViewController(
            coordinator: self)
        navigation.viewControllers = [controller]
    }
}
extension ProfileDetailCoordinatorImp: ParentCoordinator { }
