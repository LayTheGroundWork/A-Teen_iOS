//
//  MyPageRequest.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageRequest {
    public let authorization: String
    
    public init(authorization: String) {
        self.authorization = authorization
    }
}
