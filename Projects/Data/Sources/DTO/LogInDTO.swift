//
//  LogInDTO.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/28/24.
//

import Domain
import Foundation

struct LogInDTO: Decodable {
    public let status: String
    public let data: LogInData?
    public let message: String
}

extension LogInDTO {
    func toDomain() -> LogInResponse {
        .init(data: data)
    }
}
