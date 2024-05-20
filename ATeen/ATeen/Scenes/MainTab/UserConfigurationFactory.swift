//
//  UserConfigurationFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

struct UserConfigurationFactory {
    func makeUserConfigurationViewController(
        coordinator: UserConfigurationViewControllerCoordinator
    ) -> UIViewController {
        let userConfigurationViewController = UserConfigurationViewController(coordinator: coordinator)
        
        userConfigurationViewController.title = "User Configuration"
        
        return userConfigurationViewController
    }
    
    func makeAvatarViewController() -> UIViewController {
        let exampleController = ExampleViewController()
        exampleController.title = "Make your avatar"
        return exampleController
    }
}
