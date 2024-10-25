//
//  CategoryUserFindRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct CategoryUserFindRepositoryImp: CategoryUserFindRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func findCategoryUser(request: CategoryUserFindRequest) async -> Result<UserFindResponse, Error> {
        do {
            let endPoint = CategoryUserFindEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: UserFindResponse = try await apiClientService.request(request: urlRequest, type: UserFindDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
