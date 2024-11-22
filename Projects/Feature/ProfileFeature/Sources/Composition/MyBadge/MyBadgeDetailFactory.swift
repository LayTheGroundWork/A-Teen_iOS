//
//  MyBadgeDetailFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

public protocol MyBadgeDetailFactory {
    func makeMyBadgeDetailViewController(
        coordinator: MyBadgeDetailViewControllerCoordinator
    ) -> UIViewController
}

public struct MyBadgeDetailFactoryImp: MyBadgeDetailFactory {
    private (set) var badge: Badge
    
    public func makeMyBadgeDetailViewController(
        coordinator: MyBadgeDetailViewControllerCoordinator
    ) -> UIViewController {
        let controller = MyBadgeDetailViewController(
            coordinator: coordinator,
            badge: badge)
        return controller
    }
}

