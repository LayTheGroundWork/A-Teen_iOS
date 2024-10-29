//
//  UserDetailEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserDetailEndPoint: EndPoint {
    private let request: UserDetailRequest
        
    public var port: String {
        ""
    }
    
    public var path: String {
        "/v1/api/user/find/\(request.uniqueId)"
    }
    
    public var query: [String : String] = [:]
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: UserDetailRequest
    ) {
        self.request = request
    }
}

