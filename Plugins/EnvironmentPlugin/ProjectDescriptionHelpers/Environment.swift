//
//  Environment.swift
//  EnvironmentPlugin
//
//  Created by 최동호 on 6/5/24.
//

import Foundation
import ProjectDescription

public extension String {
    static let appName: String = "ATeen"
    static let displayName: String = "ATeen"
    static let organizationName: String = "ATeen"

    /// 앱스토어에 게시할 때마다 증가해줘야 하는 버전
    static let marketingVersion: Self = "1.0.0"
    /// 개발자가 내부적으로 확인하기 위한 용도 (날짜를 사용하기도 함 - 2024.06.5.1 )
    static var buildVersion: Self {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.HH.mm"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: date)
    }
}

public extension Platform {
    static let current: Self = .iOS
}

extension SettingValue {
    static let marketingVersion: Self = .string(.marketingVersion)
    static let currentProjectVersion: Self = .string(.buildVersion)
}

public extension String {
    static let bundleID: Self = "com.\(organizationName).\(appName)"
    static let targetVersion: Self = "15.0"
}

public extension DeploymentTargets {
    static let deploymentTarget: Self = iOS(.targetVersion)
}

extension Plist.Value {
    static let version: Self = "1"
    static let shortVersion: Self = "0.0.1"
    
    static let bundleDisplayName: Self = .string(.displayName)
    static let bundleShortVersionString: Self = .string(.marketingVersion)
    static let bundleVersion: Self = .string(.buildVersion)
}
