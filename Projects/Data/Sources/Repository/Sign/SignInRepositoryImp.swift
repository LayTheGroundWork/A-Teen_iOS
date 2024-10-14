//
//  SignRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 6/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SignInRepositoryImp: SignInRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (Result<(HTTPURLResponse, DefaultResponse), Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = LogInEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let result = try await apiClientService.requestToken(request: urlRequest, type: LogInDTO.self)
                let response: DefaultResponse = result.1.toDomain()
                
                completion(.success((result.0, response)))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
