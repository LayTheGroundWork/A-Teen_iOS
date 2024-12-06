//
//  DeleteAccountEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct DeleteAccountEndPoint: EndPoint {
    private let request: DeleteAccountRequest
        
    public var port: String = ""
    
    public var path: String = "/v1/api/user/delete"
    
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
        request: DeleteAccountRequest
    ) {
        self.request = request
    }
}
