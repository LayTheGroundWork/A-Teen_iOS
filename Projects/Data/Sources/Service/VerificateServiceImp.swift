//
//  VerificateServiceImp.swift
//  Data
//
//  Created by 최동호 on 6/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

final public class VerificateServiceImp: NSObject, VerificateService {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = VerificationCodeEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                try await apiClientService.request(request: urlRequest)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = PhoneNumberAuthEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                try await apiClientService.request(request: urlRequest)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }

    }
}
