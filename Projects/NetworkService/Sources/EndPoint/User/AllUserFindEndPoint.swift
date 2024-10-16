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
    
    public var path: String = "/v1/api/user/find-all"
    
    public var query: [String : String] = [:]
    
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
        request: AllUserFindRequest
    ) {
        self.request = request
    }
}
