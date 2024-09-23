//
//  LogInResponse.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct LogInResponse: Decodable {
    public let authToken: String
    public let refreshToken: String
    
    public init(
        authToken: String,
        refreshToken: String
    ) {
        self.authToken = authToken
        self.refreshToken = refreshToken
    }
}
