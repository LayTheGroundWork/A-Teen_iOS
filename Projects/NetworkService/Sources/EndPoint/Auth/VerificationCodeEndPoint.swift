//
//  VerificationCodeEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct VerificationCodeEndPoint: EndPoint {
    private let request: VerificationCodeRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/message/send"
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] {
        [
            "phoneNumber": request.phoneNumber
        ]
    }
    
    public var method: HTTPMethod = .post
    
    public init(
        request: VerificationCodeRequest
    ) {
        self.request = request
        
    }
}
