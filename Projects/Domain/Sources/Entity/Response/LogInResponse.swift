//
//  LogInResponse.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct LogInResponse {
    public let authToken: String
    
    public init(
        authToken: String
    ) {
        self.authToken = authToken
    }
}
