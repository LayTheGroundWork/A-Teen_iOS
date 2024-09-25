//
//  RequestCodeRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct RequestCodeRepositoryImp: RequestCodeRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func requestCode(request: Domain.VerificationCodeRequest, completion: @escaping () -> Void) {
        Task {
            do {
                let endPoint = VerificationCodeEndPoint(request: request)
                guard let urlRequest = endPoint.toURLRequest else {
                    throw ApiError.errorInUrl
                }
                try await apiClientService.request(request: urlRequest)
                completion()
            } catch {
                print("인증코드 요청 오류: ", error.localizedDescription)
            }
        }
    }
}
