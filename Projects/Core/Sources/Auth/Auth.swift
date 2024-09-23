//
//  Auth.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import Foundation

public protocol SessionCheckAuth {
    var isSessionActive: Bool { get }
}

public protocol LogInAuth {
    func logIn()
}

public protocol LogOutAuth {
    func logOut()
}

public protocol TokenHandler {
    func getAccessToken() -> String?
    func setAccessToken(_ accessToken: String)
    func getRefreshToken() -> String?
    func setRefreshToken(_ refreshToken: String)
}

public final class Auth {
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    private var session = false
    private var userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension Auth: SessionCheckAuth {
    public var isSessionActive: Bool {
        session
    }
}

extension Auth: TokenHandler {
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
}

extension Auth: LogInAuth {
    public func logIn() {
        session = true
    }
}

extension Auth: LogOutAuth {
    public func logOut() {
        session = false
        userDefaults.removeObject(forKey: accessTokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)
    }
}
