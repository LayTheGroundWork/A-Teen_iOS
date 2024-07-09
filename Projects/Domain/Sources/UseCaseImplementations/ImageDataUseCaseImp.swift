//
//  ImageDataUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

public struct ImageDataUseCaseImp: ImageDataUseCase {
    private(set) var imageDataRepository: ImageDataRepository
    
    public init(
        imageDataRepository: ImageDataRepository
    ) {
        self.imageDataRepository = imageDataRepository
    }
    
    public func getData(url: String?) async -> Data? {
        let convertUrl = convertToURL(url: url)
        return await imageDataRepository.fetchData(url: convertUrl)
    }
    
    public func getDataFromCache(url: String?) -> Data? {
        imageDataRepository.getFromCache(url: url)
    }
    
    private func convertToURL(url: String?) -> URL? {
        let url = URL(string: url ?? "")
        return url
    }
}
