//
//  ReissueRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct ReissueRepositoryImp: ReissueRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func reissueToken(request: ReissueRequest) async -> Result<(HTTPURLResponse, DefaultResponse), Error> {
        do {
            let endPoint = ReissueEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let result = try await apiClientService.requestToken(request: urlRequest, type: LogInDTO.self)
            let response: DefaultResponse = result.1.toDomain()
            
            return .success((result.0, response))

        } catch {
            return .failure(error)
        }
    }
}
