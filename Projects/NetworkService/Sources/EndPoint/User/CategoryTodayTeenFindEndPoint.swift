//
//  CategoryTodayTeenFindEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct CategoryTodayTeenFindEndPoint: EndPoint {
    private let request: CategoryTodayTeenFindRequest
        
    public var port: String {
        ""
    }
    
    public var path: String {
        if let _ = request.authorization {
            "/v1/api/teen/user/famous/\(request.category)"
        } else {
            "/v1/api/teen/guest/famous/\(request.category)"
        }
    }
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        if let authorization = request.authorization {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": authorization
            ]
        } else {
            [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: CategoryTodayTeenFindRequest
    ) {
        self.request = request
    }
}
