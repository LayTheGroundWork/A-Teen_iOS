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
    //func makeMyBadgeDetailCoordinator(delegate: MyBadgeDetailCoordinatorDelegate) -> Coordinator
}

public struct MyBadgeFactoryImp: MyBadgeFactory {
    private (set) var badgeList: [BadgeType]
    
    let viewModel: MyBadgeViewModel
    
    public init(badgeList: [BadgeType]) {
        self.badgeList = badgeList
        self.viewModel = MyBadgeViewModel(badgeList: badgeList)
    }
    
    public func makeMyBadgeViewController(coordinator: MyBadgeViewControllerCoordinator) -> UIViewController {
        let controller = MyBadgeViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
    
//    public func makeMyBadgeDetailCoordinator(delegate: LinksDialogCoordinatorDelegate) -> FeatureDependency.Coordinator {
//        print("뱃지 클릭")
//    }
}

