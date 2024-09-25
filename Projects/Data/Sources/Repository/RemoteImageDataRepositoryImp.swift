//
//  RemoteImageDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct RemoteImageDataRepositoryImp: RemoteImageDataRepository {
    private let apiClientService: ApiClientService

    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
        
    public func getImageData(url: URL?) async -> Data? {
        let data = await apiClientService.request(url: url)
        return data
    }
}
