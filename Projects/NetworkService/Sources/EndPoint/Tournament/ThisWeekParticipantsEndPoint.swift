//
//  ThisWeekParticipantsEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct ThisWeekParticipantsEndPoint: EndPoint {
    private let request: ThisWeekParticipantsRequest
    
    public var port: String {
        ""
    }
    
    public var path: String {
        "/v1/api/tournament/participant/\(request.category)/this-week"
    }
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: ThisWeekParticipantsRequest
    ) {
        self.request = request
    }
}
