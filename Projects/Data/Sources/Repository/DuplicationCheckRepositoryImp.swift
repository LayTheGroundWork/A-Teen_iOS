//
//  DuplicationCheckRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

final public class DuplicationCheckRepositoryImp: NSObject, DuplictaionCheckRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Result<DuplicationCheckResponse, Error>) -> Void
    ) {
        Task {
            do {
                let endPoint = DuplicationCheckEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response = try await apiClientService.request(request: urlRequest, type: DuplicationCheckDTO.self).toDomain()
                completion(.success(response))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
}
