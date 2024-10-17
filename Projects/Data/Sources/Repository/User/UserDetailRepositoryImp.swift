//
//  UserDetailRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct UserDetailRepositoryImp: UserDetailRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func getUserDetailData(
        request: UserDetailRequest,
        completion: @escaping (Result<UserDetailResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = UserDetailEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: UserDetailResponse = try await apiClientService.request(request: urlRequest, type: UserDetailDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

