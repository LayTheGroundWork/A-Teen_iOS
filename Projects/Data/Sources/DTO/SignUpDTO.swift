//
//  SignUpDTO.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct SignUpDTO: Decodable {
    public let status: String
    public let data: LogInData
    public let message: String
}

extension SignUpDTO {
    func toDomain() -> LogInResponse {
        .init(
            authToken: data.accessToken,
            refreshToken: data.refreshToken
        )
    }
}
