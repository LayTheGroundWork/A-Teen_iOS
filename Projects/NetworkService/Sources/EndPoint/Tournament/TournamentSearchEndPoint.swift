//
//  TournamentSearchEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct TournamentSearchEndPoint: EndPoint {
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/tournament/search"
    
    public var query: [String: String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init() { }
}
