//
//  UserLikeDTO.swift
//  Data
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserLikeDTO: Decodable {
    public let status: Int
    public let data: String?
    public let message: String
}

extension UserLikeDTO {
    func toDomain() -> DefaultResponse {
        .init(status: status, data: data, message: message)
    }
}

