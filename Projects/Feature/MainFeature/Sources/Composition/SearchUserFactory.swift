//
//  SearchUserFactory.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import FeatureDependency
import UIKit

public protocol SearchUserFactory {
    func makeSearchUserViewController(coordinator: SearchUserCoordinator) -> UIViewController
}

public struct SearchUserFactoryImp: SearchUserFactory {
    let viewModel = SearchUserViewModel()
    
    public init() { }
    
    public func makeSearchUserViewController(coordinator: SearchUserCoordinator) -> UIViewController {
        let controller = SearchUserViewController(
            viewModel: viewModel, coordinator: coordinator)
        return controller
    }
}
