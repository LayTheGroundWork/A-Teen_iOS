//
//  SettingsCoordinator+SettingsViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    func didSelectCell(settingsViewNavigation: SettingsViewNavigation) {
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
        userConfigurationCoordinator = factory.makeUserConfigurationCoordinator(delegate: self)
        userConfigurationCoordinator?.start()
        guard let userConfigurationCoordinator = userConfigurationCoordinator else { return }
        navigation.present(
            userConfigurationCoordinator.navigation.rootViewController,
            animated: true)
        
        userConfigurationCoordinator.navigation.dismissNavigation = { [weak self] in
            self?.userConfigurationCoordinator = nil
        }
        
    }
}

extension SettingsCoordinator: UserConfigurationCoordinatorDelegate {
    func didFinish() {
        userConfigurationCoordinator = nil
        navigation.dismiss(animated: true)
    }
}
