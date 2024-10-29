//
//  MyPageEditDTO.swift
//  Data
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct MyPageEditDTO: Decodable {
    public let status: Int
    public let data: String?
    public let message: String
    
    public init(
        status: Int,
        data: String?,
        message: String
    ) {
        self.status = status
        self.data = data
        self.message = message
    }
}

extension MyPageEditDTO {
    func toDomain() -> DefaultResponse {
        .init(
            status: status, data: data, message: message
        )
    }
}

