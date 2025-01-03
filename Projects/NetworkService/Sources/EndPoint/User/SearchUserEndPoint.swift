//
//  SearchUserEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SearchUserEndPoint: EndPoint {
    private let request: SearchUserRequest
        
    public var port: String {
        ""
    }
    
    public var path: String {
        "/v1/api/user/search/\(request.searchWord)"
    }
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: SearchUserRequest
    ) {
        self.request = request
    }
}

