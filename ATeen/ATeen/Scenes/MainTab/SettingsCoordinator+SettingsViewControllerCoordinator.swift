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
            break
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
    
}
