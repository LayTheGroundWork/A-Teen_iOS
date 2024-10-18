//
//  UserLikeCancelRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct UserLikeCancelRepositoryImp: UserLikeCancelRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func cancelUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = UserLikeCancelEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: DefaultResponse = try await apiClientService.request(request: urlRequest, type: UserLikeDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
