//
//  ProfileCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import FeatureDependency
import UIKit

public enum ProfileFeatureViewNames {
    case profile
    case another
}

public protocol ProfileCoordinatorDelegate: AnyObject {
    func didTapLogOut()
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class ProfileCoordinator: Coordinator {
    public var navigation: Navigation
    public var coordinatorProvider: CoordinatorProvider
    var factory: ProfileFactory
    weak var profileViewControllerDelegate: ProfileViewControllerDelegate?
    weak var delegate: ProfileCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []

    public init(
        navigation: Navigation,
        coordinatorProvider: CoordinatorProvider,
        factory: ProfileFactory,
        delegate: ProfileCoordinatorDelegate

    ) {
        self.navigation = navigation
        self.coordinatorProvider = coordinatorProvider
        self.factory = factory
        self.delegate = delegate
    }

    public func start() {
        let controller = factory.makeProfileViewController(coordinator: self)
        profileViewControllerDelegate = controller as? any ProfileViewControllerDelegate
        navigation.pushViewController(controller, animated: true)
    }
}

extension ProfileCoordinator: ParentCoordinator { }
