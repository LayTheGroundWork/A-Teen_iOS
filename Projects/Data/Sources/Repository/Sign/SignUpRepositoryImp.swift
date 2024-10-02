//
//  SignUpRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//
import Domain
import NetworkService
import Foundation

public struct SignUpRepositoryImp: SignUpRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = SignUpEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: Domain.LogInResponse = try await apiClientService.request(request: urlRequest, type: LogInDTO.self).toDomain()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}