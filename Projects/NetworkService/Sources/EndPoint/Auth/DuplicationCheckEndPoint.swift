//
//  DuplicationCheckEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct DuplicationCheckEndPoint: EndPoint {
    public var request: DuplicationCheckRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/user/duplication-check"
    
    public var query: [String : String] {
        ["uniqueId": request.uniqueId]
    }
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
        
    public var method: HTTPMethod = .post
    
    public init(request: DuplicationCheckRequest) {
        self.request = request
    }
}
