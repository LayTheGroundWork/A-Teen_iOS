//
//  SearchUserResponse.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Foundation

public struct SearchUserResponse: Decodable {
    public let data: [SearchUserData]
    
    public init(data: [SearchUserData]) {
        self.data = data
    }
}

public struct SearchUserData: Decodable {
    public let uniqueId: String
    public let thumbnailUrl: String
    public let nickName: String
    
    public init(
        uniqueId: String,
        thumbnailUrl: String,
        nickName: String
    ) {
        self.uniqueId = uniqueId
        self.thumbnailUrl = thumbnailUrl
        self.nickName = nickName
    }
}
