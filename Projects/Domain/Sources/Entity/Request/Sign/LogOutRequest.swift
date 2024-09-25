//
//  LogOutRequest.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public struct LogOutRequest {
    public let authorization: String
    
    public init(authorization: String) {
        self.authorization = authorization
    }
}
