//
//  VerificationCodeDTO.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct VerificationCodeDTO: Decodable {
    public let status: String
    public let data: String?
    public let message: String
    
    public init(
        status: String,
        data: String?,
        message: String
    ) {
        self.status = status
        self.data = data
        self.message = message
    }
}

extension VerificationCodeDTO {
    func toDomain() -> DefaultResponse {
        .init(
            status: status, data: data, message: message
        )
    }
}
