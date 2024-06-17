//
//  SettingsCoordinator+SettingsViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    public func didSelectCell(settingsViewNavigation: SettingsViewNavigation) {
        switch settingsViewNavigation {
        case .userConfiguration:
            cellUserConfigurationCoordinator()
        case .account:
            navigation.pushViewController(factory.makeAccountViewController(), animated: true)
        case .theme:
            navigation.pushViewController(factory.makeThemeViewController(), animated: true)
        case .logout:
            delegate?.didTapLogOut()
        case .noNavigation:
            break
        }
    }
    
    private func cellUserConfigurationCoordinator() {
        let userConfigurationCoordinator = factory.makeUserConfigurationCoordinator(delegate: self)
        addChildCoordinatorStart(userConfigurationCoordinator)
      
        navigation.present(
            userConfigurationCoordinator.navigation.rootViewController,
            animated: true)
        
        userConfigurationCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.removeChildCoordinator(userConfigurationCoordinator)
        }
        
    }
}

