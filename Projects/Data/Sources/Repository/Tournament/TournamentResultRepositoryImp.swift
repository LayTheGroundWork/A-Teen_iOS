//
//  TournamentResultRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct TournamentResultRepositoryImp: TournamentResultRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func getTournamentResult(request: TournamentResultRequest) async -> Result<TournamentResultResponse, Error> {
        do {
            let endPoint = TournamentResultEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: TournamentResultResponse = try await apiClientService.request(request: urlRequest, type: TournamentResultDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}

