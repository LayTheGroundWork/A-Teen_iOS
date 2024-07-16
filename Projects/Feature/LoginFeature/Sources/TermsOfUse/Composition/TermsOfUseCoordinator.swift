//
//  TermsOfUseCoordinator.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import Common
import FeatureDependency
import Foundation

public protocol TermsOfUseCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class TermsOfUseCoordinator: Coordinator {
    public let phoneNumber: String
    public var navigation: Navigation
    var factory: TermsOfUseFactory
    public var childCoordinators: [Coordinator]
    weak var delegate: TermsOfUseCoordinatorDelegate?
    
    public init(
        phoneNumber: String,
        navigation: Navigation,
         factory: TermsOfUseFactory,
         childCoordinators: [Coordinator],
         delegate: TermsOfUseCoordinatorDelegate
    ) {
        self.phoneNumber = phoneNumber
        self.navigation = navigation
        self.factory = factory
        self.childCoordinators = childCoordinators
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeTermsOfUseViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension TermsOfUseCoordinator: ParentCoordinator { }
