//
//  RemoteImageDataServiceImp.swift
//  Data
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct RemoteImageDataServiceImp: RemoteImageDataService {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }

    public func request(url: URL?) async -> Data? {
        await apiClientService.request(url: url)
    }
}
