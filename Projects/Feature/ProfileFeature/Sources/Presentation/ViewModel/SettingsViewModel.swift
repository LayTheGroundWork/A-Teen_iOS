//
//  SettingsViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Common

class SettingsViewModel {
    var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
}

extension SettingsViewModel {
    func changeTextFromVideoTypeNumber() -> String {
        switch userSettings.videoPlayType {
        case 0:
            "모바일 데이터 및 Wi-Fi 연결 시"
        case 1:
            "Wi-Fi에서만"
        case 2:
            "사용 안 함"
        default:
            ""
        }
    }
    
    func changeVideoType(_ type: Int) {
        // TODO: Setting API 필요
        userSettings.videoPlayType = type
    }
    
    func changeSettingValue(_ index: Int) {
        // TODO: Setting API 필요
        switch index {
        case 0:
            userSettings.isNotificationSetting.toggle()
        case 1:
            userSettings.isTournamentJoin.toggle()
        default:
            break
        }
    }
    
    func deleteUser() {
        
    }
}
