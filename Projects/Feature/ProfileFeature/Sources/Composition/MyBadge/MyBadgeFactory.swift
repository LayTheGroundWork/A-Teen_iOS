//
//  MyBadgeFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol MyBadgeFactory {
    func makeMyBadgeViewController(coordinator: MyBadgeViewControllerCoordinator) -> UIViewController
    func makeMyBadgeDetailCoordinator(
        delegate: MyBadgeDetailCoordinatorDelegate,
        badge: Badge
    ) -> Coordinator
}

public struct MyBadgeFactoryImp: MyBadgeFactory {
    private (set) var badgeList: [Badge]
    
    let viewModel: MyBadgeViewModel
    
    public init(badgeList: [Badge]) {
        self.badgeList = badgeList
        self.viewModel = MyBadgeViewModel(badgeList: badgeList)
    }
    
    public func makeMyBadgeViewController(coordinator: MyBadgeViewControllerCoordinator) -> UIViewController {
        let controller = MyBadgeViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
    public func makeMyBadgeDetailCoordinator(delegate: MyBadgeDetailCoordinatorDelegate, badge: Badge) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = MyBadgeDetailFactoryImp(badge: badge)
        
        let coordinator = MyBadgeDetailCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
        return coordinator
    }
}

