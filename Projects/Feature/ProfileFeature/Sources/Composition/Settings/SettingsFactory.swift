//
//  SettingsFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Common
import FeatureDependency
import UIKit

public protocol SettingsFactory {
    func makeSettingsCotroller(
        coordinator: SettingsViewControllerCoordinator
    ) -> UIViewController
}

public struct SettingsFactoryImp: SettingsFactory {
    var viewModel: SettingsViewModel

    public init(userSettings: UserSettings) {
        viewModel = SettingsViewModel(userSettings: userSettings)
    }
    
    public func makeSettingsCotroller(
        coordinator: SettingsViewControllerCoordinator
    ) -> UIViewController {
        let controller = SettingsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
 
        return controller
    }
}
