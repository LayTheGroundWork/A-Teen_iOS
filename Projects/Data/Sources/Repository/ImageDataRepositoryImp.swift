//
//  ImageDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Domain
import Foundation

public struct ImageDataRepositoryImp: ImageDataRepository {
    private(set) var remoteDataService: RemoteImageDataService
    private(set) var localDataCache: LocalDataImageService
    
    public init(
        remoteDataService: RemoteImageDataService,
        localDataCache: LocalDataImageService
    ) {
        self.remoteDataService = remoteDataService
        self.localDataCache = localDataCache
    }
        
    public func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataService.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    public func getFromCache(url: String?) -> Data? {
        localDataCache.get(key: url ?? .empty)
    }
}
