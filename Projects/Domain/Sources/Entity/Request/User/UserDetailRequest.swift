//
//  UserDetailRequest.swift
//  Domain
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct UserDetailRequest {
    public let uniqueId: String
    
    public init(
        uniqueId: String
    ) {
        self.uniqueId = uniqueId
    }
}

