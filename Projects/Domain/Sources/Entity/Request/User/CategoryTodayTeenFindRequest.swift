//
//  CategoryTodayTeenFindRequest.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Foundation

public struct CategoryTodayTeenFindRequest {
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
