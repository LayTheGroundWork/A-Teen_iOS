//
//  LogOutEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct LogOutEndPoint: EndPoint {
    private let request: LogOutRequest
        
    public var port: String = ""
    
    public var path: String = "/v1/api/user/sign-out"
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .delete
    
    public init(
        request: LogOutRequest
    ) {
        self.request = request
    }
}

