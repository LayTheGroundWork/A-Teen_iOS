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
    public let data: LogInData
    public let message: String
}

struct LogInData: Decodable {
    public let grantType: String
    public let accessToken: String
    public let accessTokenExpiresIn: Int
    public let refreshToken: String
}

extension LogInDTO {
    func toDomain() -> LogInResponse {
        .init(authToken: data.accessToken)
    }
}
