//
//  CategoryTodayTeenFindRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct CategoryTodayTeenFindRepositoryImp: CategoryTodayTeenFindRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func findCategoryTodayTeen(request: CategoryTodayTeenFindRequest) async -> Result<TodayTeenFindResponse, Error> {
        do {
            let endPoint = CategoryTodayTeenFindEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: TodayTeenFindResponse = try await apiClientService.request(request: urlRequest, type: TodayTeenFindDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
