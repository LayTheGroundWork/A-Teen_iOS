//
//  VerificationCodeRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct VerificationCodeRepositoryImp: VerificationCodeRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func verificareCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = PhoneNumberAuthEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response = try await apiClientService.request(request: urlRequest, type: VerificationCodeDTO.self).toDomain()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
