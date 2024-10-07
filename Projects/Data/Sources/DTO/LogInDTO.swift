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
    public let data: LogInDetailData?
    public let message: String
}

struct LogInDetailData: Decodable {
    public let grantType: String
    public let accessToken: String
    public let accessTokenExpiresIn: Int
    public let refreshToken: String
}

extension LogInDTO {
    func toDomain() -> LogInResponse {
        guard let data = data else {
            return .init(data: nil)
        }
        
        let loginData: LogInData = .init(
            grantType: data.grantType,
            accessToken: data.accessToken,
            accessTokenExpiresIn: data.accessTokenExpiresIn,
            refreshToken: data.refreshToken)
        
        return .init(data: loginData)
    }
}
