//
//  SettingsViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core

final class SettingsViewModel {
    private var itemSettingViewModel: [ItemSettingViewModel] = [
        ItemSettingViewModel(
            title: "User Configuration",
            icon: "person",
            isNavigable: true,
            navigation: .userConfiguration),
        ItemSettingViewModel(
            title: "Account",
            icon: "archivebox.circle",
            isNavigable: true,
            navigation: .account),
        ItemSettingViewModel(
            title: "Theme",
            icon: "paintbrush",
            isNavigable: true,
            navigation: .theme),
        ItemSettingViewModel(
            title: "LogOut",
            icon: "door.right.hand.open",
            isNavigable: true,
            navigation: .logout),
        ItemSettingViewModel(
            title: "Version App 1.0.0",
            icon: "apps.iphone",
            isNavigable: false,
            navigation: .noNavigation),
    ]
    
    private let auth: LogOutAuth?
    
    var settingsCount: Int {
        itemSettingViewModel.count
    }
    
    init(auth: LogOutAuth? = nil) {
        self.auth = auth
    }
    
    private func logOut() {
        auth?.logOut()
    }
    
    func getItemSettingsViewModel(row: Int) -> ItemSettingViewModel {
        itemSettingViewModel[row]
    }
    
    func cellSelected(row: Int) -> SettingsViewNavigation {
        let navigation = itemSettingViewModel[row].navigation
        if navigation == .logout {
            logOut()
        }
        
        return navigation
    }
}
