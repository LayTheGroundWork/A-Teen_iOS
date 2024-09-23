//
//  LogOutResponse.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public struct LogOutResponse {
    public let status: String
    public let data: String
    public let message: String
    
    public init(
        status: String,
        data: String,
        message: String
    ) {
        self.status = status
        self.data = data
        self.message = message
    }
}
