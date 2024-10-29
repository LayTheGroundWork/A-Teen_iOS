//
//  UserDetailDTO.swift
//  Data
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserDetailDTO: Decodable {
    public let status: Int
    public let data: UserDetailData
    public let message: String
}

extension UserDetailDTO {
    func toDomain() -> UserDetailResponse {
        .init(data: data)
    }
}
