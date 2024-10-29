//
//  TokenStorage.swift
//  Data
//
//  Created by 노주영 on 10/14/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Foundation

public class TokenStorage: TokenHandler {
    private let userDefaults: UserDefaults
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func getAccessToken() -> String? {
        return userDefaults.string(forKey: accessTokenKey)
    }
    
    public func setAccessToken(_ accessToken: String) {
        userDefaults.set(accessToken, forKey: accessTokenKey)
    }
    
    public func getRefreshToken() -> String? {
        return userDefaults.string(forKey: refreshTokenKey)
    }
    
    public func setRefreshToken(_ refreshToken: String) {
        userDefaults.set(refreshToken, forKey: refreshTokenKey)
    }
    
    public func deleteToken() {
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
    }
}
