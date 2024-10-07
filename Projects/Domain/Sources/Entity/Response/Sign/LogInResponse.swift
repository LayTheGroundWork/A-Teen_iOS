//
//  LogInResponse.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct LogInResponse: Decodable {
    public let data: LogInData?
    
    public init(data: LogInData?) {
        self.data = data
    }
}

public struct LogInData: Decodable {
    public let grantType: String
    public let accessToken: String
    public let accessTokenExpiresIn: Int
    public let refreshToken: String
    
    public init(
        grantType: String,
        accessToken: String,
        accessTokenExpiresIn: Int,
        refreshToken: String
    ) {
        self.grantType = grantType
        self.accessToken = accessToken
        self.accessTokenExpiresIn = accessTokenExpiresIn
        self.refreshToken = refreshToken
    }
}
