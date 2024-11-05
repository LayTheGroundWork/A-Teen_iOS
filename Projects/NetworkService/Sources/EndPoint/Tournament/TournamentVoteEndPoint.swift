//
//  TournamentVoteEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentVoteEndPoint: EndPoint {
    private let request: TournamentVoteRequest
    
    public var port: String {
        ""
    }
    
    public var path: String = "/v1/api/tournament/final/vote"
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": request.authorization
        ]
    }
    
    public var body: [String : Any] {
        [
            "tournamentNo": request.tournamentNo,
            "participantIdsOrderByRank": request.participantIdsOrderByRank
        ]
    }
    
    public var method: HTTPMethod = .post
    
    public init(
        request: TournamentVoteRequest
    ) {
        self.request = request
    }
}
