//
//  SignOutRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SignOutRepositoryImp: SignOutRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func signOut(request: Domain.LogOutRequest, completion: @escaping (Result<Domain.DefaultResponse, Error>) -> Void) {
        Task {
            do {
                let endPoint = LogOutEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: DefaultResponse = try await apiClientService.request(request: urlRequest, type: LogOutDTO.self).toDomain()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
