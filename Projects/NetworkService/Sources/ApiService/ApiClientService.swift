//
//  ApiClientService.swift
//  NetworkService
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol ApiClientService {
    func request(request: URLRequest) async throws -> Void
    func request<T: Decodable>(request: URLRequest) async throws -> T
}
