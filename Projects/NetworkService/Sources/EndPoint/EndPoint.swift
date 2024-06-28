//
//  EndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol EndPoint {
    var path: String { get }
    var query: [String: String] { get }
    var header: [String: String] { get }
    var body: [String: Any] { get }
    var method: HTTPMethod { get }
}

extension EndPoint {
    var host: String {
        Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as? String ?? ""
    }
}
