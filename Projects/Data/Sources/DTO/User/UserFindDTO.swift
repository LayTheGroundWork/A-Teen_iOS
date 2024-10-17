//
//  UserFindDTO.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserFindDTO: Decodable {
    public let status: Int
    public let data: [UserData]
    public let message: String
}

extension UserFindDTO {
    func toDomain() -> UserFindResponse {
        .init(data: data)
    }
}
