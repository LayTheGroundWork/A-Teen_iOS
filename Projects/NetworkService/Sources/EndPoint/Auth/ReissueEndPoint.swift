//
//  ReissueEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct ReissueEndPoint: EndPoint {
    private let request: ReissueRequest
        
    public var port: String = ""
    
    public var path: String = "/v1/api/user/reissue"
    
    public var query: [String: String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Refresh": request.refresh,
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .put
    
    public init(
        request: ReissueRequest
    ) {
        self.request = request
    }
    
}
