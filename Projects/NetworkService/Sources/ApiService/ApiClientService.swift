//
//  ApiClientService.swift
//  NetworkService
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol ApiClientService {
    func request(url: URL?) async -> Data?
    func request(request: URLRequest) async throws -> Void
    func request<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T
}
