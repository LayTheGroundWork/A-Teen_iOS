//
//  TournamentSearchRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct TournamentSearchRepositoryImp: TournamentSearchRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func searchTournament() async -> Result<TournamentSearchResponse, Error> {
        do {
            let endPoint = TournamentSearchEndPoint()
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: TournamentSearchResponse = try await apiClientService.request(request: urlRequest, type: TournamentSearchDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
