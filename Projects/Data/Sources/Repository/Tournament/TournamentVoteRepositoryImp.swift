//
//  TournamentVoteRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct TournamentVoteRepositoryImp: TournamentVoteRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func tournamentVote(request: TournamentVoteRequest) async -> Result<DefaultResponse, Error> {
        do {
            let endPoint = TournamentVoteEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: DefaultResponse = try await apiClientService.request(request: urlRequest, type: TournamentVoteDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
