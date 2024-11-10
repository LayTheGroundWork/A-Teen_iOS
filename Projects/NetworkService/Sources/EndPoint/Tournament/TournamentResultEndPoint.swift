//
//  TournamentResultEndPoint.swift
//  NetworkService
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentResultEndPoint: EndPoint {
    private let request: TournamentResultRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/tournament/final/result"
    
    public var query: [String : String] {
        [
            "tournamentNo": String(request.tournamentNo)
        ]
    }
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: TournamentResultRequest
    ) {
        self.request = request
    }
}
