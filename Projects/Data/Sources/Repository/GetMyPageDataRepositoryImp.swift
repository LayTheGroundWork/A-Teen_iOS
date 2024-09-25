//
//  GetMyPageDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct GetMyPageDataRepositoryImp: GetMyPageDataRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func getMyPageData(
        request: MyPageRequest,
        completion: @escaping (Result<MyPageResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = MyPageEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: MyPageResponse = try await apiClientService.request(request: urlRequest, type: MyPageDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
