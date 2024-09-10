//
//  EditUserNameFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol EditUserNameFactory {
    func makeUserNameViewController(coordinator: EditUserNameViewControllerCoordinator) -> UIViewController
}

public struct EditUserNameFactoryImp: EditUserNameFactory {
    private(set) var userName: String
    
    public func makeUserNameViewController(coordinator: EditUserNameViewControllerCoordinator) -> UIViewController {
        let viewModel = EditUserNameViewModel(
            userName: userName,
            changeUserName: userName)
        let controller = EditUserNameViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}

