//
//  CategoryUserFindRequest.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct CategoryUserFindRequest {
    public let authorization: String?
    public let category: String
    
    public init(
        authorization: String?,
        category: String
    ) {
        self.authorization = authorization
        self.category = category
    }
}
