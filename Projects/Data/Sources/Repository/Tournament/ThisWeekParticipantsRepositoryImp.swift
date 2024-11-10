//
//  ThisWeekParticipantsRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct ThisWeekParticipantsRepositoryImp: ThisWeekParticipantsRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func getThisWeekParticipants(request: ThisWeekParticipantsRequest) async -> Result<ThisWeekParticipantsResponse, Error> {
        do {
            let endPoint = ThisWeekParticipantsEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: ThisWeekParticipantsResponse = try await apiClientService.request(request: urlRequest, type: ThisWeekParticipantsDTO.self).toDomain()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
