//
//  SignUpEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 6/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SignUpEndPoint: EndPoint {
    private let request: SignUpRequest
        
    public var path: String = "/v1/api/user/sign-up"
    
    public var query: [String: String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] {
        [
            "phoneNumber": request.phoneNumber,
            "uniqueId": request.userId,
            "nickName": request.userName,
            "birthDay": request.birthDate,
            "schoolData": request.schoolData
        ]
    }
    
    public var method: HTTPMethod = .post
    
    public init(
        request: SignUpRequest
    ) {
        self.request = request
    }
    
}
