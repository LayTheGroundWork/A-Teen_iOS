//
//  LogInEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct LogInEndPoint: EndPoint {
    private let request: LogInRequest
        
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/user/sign-in"
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] {
        [
            "phoneNumber": request.phoneNumber,
            "verificationCode": request.verificationCode
        ]
    }
    
    public var method: HTTPMethod = .post
    
    public init(
        request: LogInRequest
    ) {
        self.request = request
    }
}
