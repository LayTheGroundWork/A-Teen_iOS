//
//  EditSchoolFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import UIKit

public protocol EditSchoolFactory {
    func makeEditSchoolViewController(coordinator: EditSchoolViewControllerCoordinator) -> UIViewController
}

public struct EditSchoolFactoryImp: EditSchoolFactory {
    private(set) var user: MyPageData
    
    public func makeEditSchoolViewController(coordinator: EditSchoolViewControllerCoordinator) -> UIViewController {
        let viewModel = EditSchoolViewModel(user: user)
        let controller = EditSchoolViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
