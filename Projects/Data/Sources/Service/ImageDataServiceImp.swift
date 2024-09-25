//
//  ImageDataServiceImp.swift
//  Data
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct ImageDataServiceImp: ImageDataService {
    private let remoteImageDataRepository: RemoteImageDataRepository
    private var dataStorage = NSCache<NSString, NSData>()
    
    public init(remoteImageDataRepository: RemoteImageDataRepository) {
        self.remoteImageDataRepository = remoteImageDataRepository
    }
    
    public func fetchData(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        
        let cacheKey = url.absoluteString
        
        if let cachedData = getFromCache(key: cacheKey) {
            return cachedData
        }
        
        if let fetchedData = await remoteImageDataRepository.getImageData(url: url) {
            save(key: cacheKey, data: fetchedData)
            return fetchedData
        }
        
        return nil
    }
    
    private func save(key: String, data: Data?) {
        guard let data = data else { return }
        dataStorage.setObject(data as NSData, forKey: key as NSString)
    }
    
    private func getFromCache(key: String) -> Data? {
        dataStorage.object(forKey: key as NSString) as? Data
    }
    
}
