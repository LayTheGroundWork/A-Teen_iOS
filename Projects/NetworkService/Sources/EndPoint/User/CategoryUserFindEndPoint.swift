//
//  CategoryUserFindEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct CategoryUserFindEndPoint: EndPoint {
    private let request: CategoryUserFindRequest
        
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/user/find-all-by-category"
    
    public var query: [String : String] {
        [
            "category": request.category
        ]
    }
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .post
    
    public init(
        request: CategoryUserFindRequest
    ) {
        self.request = request
    }
}
