//
//  MyPageRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct MyPageRepositoryImp: MyPageRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func getMyPageData(request: MyPageRequest) async -> Result<MyPageResponse, Error> {
        do {
            let endPoint = MyPageEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: MyPageResponse = try await apiClientService.request(request: urlRequest, type: MyPageDTO.self).toDomain()
            
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
