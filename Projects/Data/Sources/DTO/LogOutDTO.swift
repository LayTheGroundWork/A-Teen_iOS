//
//  LogOutDTO.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct LogOutDTO: Decodable {
    public let status: String
    public let data: String
    public let message: String
}

extension LogOutDTO {
    func toDomain() -> LogOutResponse {
        return .init(
            status: status,
            data: data,
            message: message
        )
    }
}
