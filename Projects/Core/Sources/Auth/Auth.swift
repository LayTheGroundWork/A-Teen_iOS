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
    func deleteToken()
}

public final class Auth {
    private var session = false
    private let tokenHandler: TokenHandler
    
    public init(tokenHandler: TokenHandler) {
        self.tokenHandler = tokenHandler
    }
}

extension Auth {
    public func getAccessToken() -> String? {
        return tokenHandler.getAccessToken()
    }
    
    public func setAccessToken(_ accessToken: String) {
        tokenHandler.setAccessToken(accessToken)
    }
    
    public func getRefreshToken() -> String? {
        return tokenHandler.getRefreshToken()
    }
    
    public func setRefreshToken(_ refreshToken: String) {
        tokenHandler.setRefreshToken(refreshToken)
    }
}

extension Auth: SessionCheckAuth {
    public var isSessionActive: Bool {
        session
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
        tokenHandler.deleteToken()
    }
}
