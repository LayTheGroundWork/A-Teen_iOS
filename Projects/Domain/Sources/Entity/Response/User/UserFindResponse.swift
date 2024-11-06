//
//  UserFindResponse.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

public struct UserFindResponse: Decodable {
    public let data: UserData
    
    public init(data: UserData) {
        self.data = data
    }
}

public struct UserData: Decodable {
    public let users: [User]
    public let totalPage: Int
    
    public init(
        users: [User],
        totalPage: Int
    ) {
        self.users = users
        self.totalPage = totalPage
    }
}

