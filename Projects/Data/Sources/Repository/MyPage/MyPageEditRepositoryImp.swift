//
//  MyPageEditRepositoryImp.swift
//  Data
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct MyPageEditRepositoryImp: MyPageEditRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func editMyPage(
        request: MyPageEditRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = MyPageEditEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: DefaultResponse = try await apiClientService.request(request: urlRequest, type: MyPageEditDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

