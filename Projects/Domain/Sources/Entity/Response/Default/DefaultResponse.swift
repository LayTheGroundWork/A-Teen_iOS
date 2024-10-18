//
//  DefaultResponse.swift
//  Domain
//
//  Created by 최동호 on 7/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public struct DefaultResponse {
    public let status: Int
    public let data: String?
    public let message: String
    
    public init(
        status: Int,
        data: String?,
        message: String
    ) {
        self.status = status
        self.data = data
        self.message = message
    }
}
