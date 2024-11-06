//
//  Auth.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import Foundation

public protocol TokenHandler {
    func getAccessToken() -> String?
    func setAccessToken(_ accessToken: String)
    func getRefreshToken() -> String?
    func setRefreshToken(_ refreshToken: String)
    func deleteToken()
}

public final class Auth {
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
    
    public func logOut() {
        tokenHandler.deleteToken()
    }
}
