//
//  ImageDataUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ImageDataUseCaseImp: ImageDataUseCase {
    private(set) var imageDataService: ImageDataService
        
    public init(
        imageDataService: ImageDataService
    ) {
        self.imageDataService = imageDataService
    }
    
    public func getData(url: String?) async -> Data? {
        let convertUrl = convertToURL(url: url)
        return await imageDataService.fetchData(url: convertUrl)
    }
    
    private func convertToURL(url: String?) -> URL? {
        let url = URL(string: url ?? "")
        return url
    }
}
