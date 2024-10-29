//
//  UserLikeRequest.swift
//  Domain
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct UserLikeRequest {
    public let authorization: String
    public let id: Int
    
    public init(
        authorization: String,
        id: Int
    ) {
        self.authorization = authorization
        self.id = id
    }
}
