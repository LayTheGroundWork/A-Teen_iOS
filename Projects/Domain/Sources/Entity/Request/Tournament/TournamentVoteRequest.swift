//
//  TournamentVoteRequest.swift
//  Domain
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct TournamentVoteRequest {
    public let authorization: String
    public let tournamentNo: Int
    public let participantIdsOrderByRank: [String]
    
    public init(
        authorization: String,
        tournamentNo: Int,
        participantIdsOrderByRank: [String]
    ) {
        self.authorization = authorization
        self.tournamentNo = tournamentNo
        self.participantIdsOrderByRank = participantIdsOrderByRank
    }
}
