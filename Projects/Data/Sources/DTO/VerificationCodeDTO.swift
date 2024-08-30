//
//  VerificationCodeDTO.swift
//  Data
//
//  Created by 노주영 on 8/30/24.
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
    func toDomain() -> VerificationCodeResponse {
        .init(
            status: status, data: data, message: message
        )
    }
}

