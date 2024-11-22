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
    func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController
}

public struct SettingsFactoryImp: SettingsFactory {
    private (set) var userSettings: UserSettings

    public init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    public func makeSettingsCotroller(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(userSettings: userSettings)
        let controller = SettingsViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
