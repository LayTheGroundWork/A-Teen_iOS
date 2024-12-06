//
//  UserSettings.swift
//  Common
//
//  Created by 노주영 on 11/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

// 추후에 API 생기면 거기로 옮길 예정
public struct UserSettings {
    public var isNotificationSetting: Bool
    public var isTournamentJoin: Bool
    public var videoPlayType: Int // 0: 둘다 가능, 1: WIFI만, 2: 둘다 불가능
    
    public init(
        isNotificationSetting: Bool,
        isTournamentJoin: Bool,
        videoPlayType: Int
    ) {
        self.isNotificationSetting = isNotificationSetting
        self.isTournamentJoin = isTournamentJoin
        self.videoPlayType = videoPlayType
    }
}
