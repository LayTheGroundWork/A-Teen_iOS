//
//  AllUserFindEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct AllUserFindEndPoint: EndPoint {
    private let request: AllUserFindRequest
        
    public var port: String {
        ""
    }
    
    public var path: String {
        if let _ = request.authorization {
            "/v1/api/user/find-all"
        } else {
            "/v1/api/guest/find-all"
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
    
    public var method: HTTPMethod = .post
    
    public init(
        request: AllUserFindRequest
    ) {
        self.request = request
    }
}
