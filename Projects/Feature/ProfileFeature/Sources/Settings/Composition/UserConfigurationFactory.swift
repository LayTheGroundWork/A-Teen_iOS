//
//  UserConfigurationFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

public struct UserConfigurationFactory {
    public func makeUserConfigurationViewController(
        coordinator: UserConfigurationViewControllerCoordinator
    ) -> UIViewController {
        let userConfigurationViewController = UserConfigurationViewController(coordinator: coordinator)
        
        userConfigurationViewController.title = "User Configuration"
        
        return userConfigurationViewController
    }
    
    public func makeAvatarViewController() -> UIViewController {
        let exampleController = ExampleViewController()
        exampleController.title = "Profile Edit"
        return exampleController
    }
}
