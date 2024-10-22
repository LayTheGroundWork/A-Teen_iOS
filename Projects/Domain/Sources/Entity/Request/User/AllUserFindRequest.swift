//
//  AllUserFindRequest.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct AllUserFindRequest {
    public let authorization: String?
    
    public init(authorization: String?) {
        self.authorization = authorization
    }
}
