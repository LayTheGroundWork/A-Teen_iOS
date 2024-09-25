//
//  MyPageEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct MyPageEndPoint: EndPoint {
    private let request: MyPageRequest
        
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/my-page"
    
    public var query: [String: String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: MyPageRequest
    ) {
        self.request = request
    }
    
}
