//
//  TodayTeenFindDTO.swift
//  Data
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Common
import Domain
import Foundation

public struct TodayTeenFindDTO: Decodable {
    public let status: Int
    public let data: [User]
    public let message: String
}

extension TodayTeenFindDTO {
    func toDomain() -> TodayTeenFindResponse {
        .init(data: data)
    }
}
