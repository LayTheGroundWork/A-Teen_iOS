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
    public let page: Int
    public let size: Int
    
    public init(
        authorization: String?,
        category: String,
        page: Int,
        size: Int
    ) {
        self.authorization = authorization
        self.category = category
        self.page = page
        self.size = size
    }
}
