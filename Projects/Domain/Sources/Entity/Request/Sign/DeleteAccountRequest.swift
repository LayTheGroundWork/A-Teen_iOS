//
//  DeleteAccountRequest.swift
//  Domain
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public struct DeleteAccountRequest {
    public let authorization: String
    
    public init(authorization: String) {
        self.authorization = authorization
    }
}
