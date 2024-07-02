//
//  ImageDataRepository.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol ImageDataRepository {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: String?) -> Data?
}
