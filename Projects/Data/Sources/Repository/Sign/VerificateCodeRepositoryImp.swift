//
//  VerificateCodeRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct VerificateCodeRepositoryImp: VerificateCodeRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func verificateCode(request: Domain.PhoneNumberAuthRequest, completion: @escaping (Result<Domain.VerificationCodeResponse, Error>) -> Void) {
        Task {
            do {
                let endPoint = PhoneNumberAuthEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                try await apiClientService.request(request: urlRequest)
                completion(.success(.availablePhoneNumber))
            } catch {
                if let apiError = error as? ApiError, apiError == .existedUserError {
                            completion(.success(.existedUser))
                } else {
                    print("인증코드 인증 오류: ", error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
