//
//  SearchUserRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct SearchUserRepositoryImp: SearchUserRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func searchUserList(request: SearchUserRequest) async -> Result<SearchUserResponse, Error> {
        do {
            let endPoint = SearchUserEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: SearchUserResponse = try await apiClientService.request(request: urlRequest, type: SearchUserDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
