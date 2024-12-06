//
//  DeleteAccountDTO.swift
//  Data
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct DeleteAccountDTO: Decodable {
    public let status: Int
    public let data: String?
    public let message: String
}

extension DeleteAccountDTO {
    func toDomain() -> DefaultResponse {
        return .init(
            status: status,
            data: data,
            message: message
        )
    }
}
