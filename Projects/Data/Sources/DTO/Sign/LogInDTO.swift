//
//  LogInDTO.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/28/24.
//

import Domain
import Foundation

struct LogInDTO: Decodable {
    public let status: Int
    public let data: String?
    public let message: String
}

extension LogInDTO {
    func toDomain() -> DefaultResponse {
        .init(status: status, data: data, message: message)
    }
}
