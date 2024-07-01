//
//  RemoteImageDataService.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol RemoteImageDataService {
    func request(url: URL?) async -> Data?
}
