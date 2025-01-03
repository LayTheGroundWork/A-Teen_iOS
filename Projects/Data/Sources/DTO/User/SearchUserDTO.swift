//
//  SearchUserDTO.swift
//  Data
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SearchUserDTO: Decodable {
    public let status: Int
    public let data: [SearchUserData]
    public let message: String
}

extension SearchUserDTO {
    func toDomain() -> SearchUserResponse {
        .init(data: data)
    }
}

