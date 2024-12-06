//
//  DeleteAccountRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct DeleteAccountRepositoryImp: DeleteAccountRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func deleteAccount(request: DeleteAccountRequest) async -> Result<DefaultResponse, Error> {
        do {
            let endPoint = DeleteAccountEndPoint(request: request)
            guard let urlRequest = endPoint.toURLRequest else {
                throw ApiError.errorInUrl
            }
            let response: DefaultResponse = try await apiClientService.request(request: urlRequest, type: LogOutDTO.self).toDomain()
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
