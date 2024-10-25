//
//  DuplicationCheckRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct DuplicationCheckRepositoryImp: DuplictaionCheckRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func duplicationCheck(request: DuplicationCheckRequest) async -> Result<DuplicationCheckResponse, Error> {
        do {
            let endPoint = DuplicationCheckEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response = try await apiClientService.request(request: urlRequest, type: DuplicationCheckDTO.self).toDomain()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
