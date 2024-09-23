//
//  DuplicationCheckDTO.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct DuplicationCheckDTO: Decodable {
    public let status: String
    public let data: Bool
    public let message: String
    
    public init(
        status: String,
        data: Bool,
        message: String
    ) {
        self.status = status
        self.data = data
        self.message = message
    }
}

extension DuplicationCheckDTO {
    func toDomain() -> DuplicationCheckResponse {
        .init(data: data)
    }
}
