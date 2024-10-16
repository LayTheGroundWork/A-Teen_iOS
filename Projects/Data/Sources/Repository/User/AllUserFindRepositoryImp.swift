//
//  AllUserFindRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation
import NetworkService

public struct AllUserFindRepositoryImp: AllUserFindRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func findAllUser(
        request: AllUserFindRequest,
        completion: @escaping (Result<UserFindResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = AllUserFindEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: UserFindResponse = try await apiClientService.request(request: urlRequest, type: UserFindDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
