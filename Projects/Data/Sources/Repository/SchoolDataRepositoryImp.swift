//
//  SchoolDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SchoolDataRepositoryImp: SchoolDataRepository {
    
    let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }

    public func searchSchool(request: SchoolDataRequest, completion: @escaping (Result<[SchoolDataResponse], Error>) -> Void) {
        Task {
            do {
                let endPoint = SchoolDataEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                let response: [SchoolDataResponse] = try await apiClientService.request(request: urlRequest, type: SchoolDataDTO.self).toDomain()

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
