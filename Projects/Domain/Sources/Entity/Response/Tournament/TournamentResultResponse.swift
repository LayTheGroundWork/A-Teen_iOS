//
//  TournamentResultResponse.swift
//  Domain
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct TournamentResultResponse: Decodable {
    public let data: [TournamentResultData]
    
    public init(data: [TournamentResultData]) {
        self.data = data
    }
}

public struct TournamentResultData: Decodable {
    public let rankerId: String
    public let rankerNickName: String
    public let rank: Int
    public let voteCount: Int
    public let profileImageUrl: String
    
    public init(
        rankerId: String,
        rankerNickName: String,
        rank: Int, 
        voteCount: Int,
        profileImageUrl: String
    ) {
        self.rankerId = rankerId
        self.rankerNickName = rankerNickName
        self.rank = rank
        self.voteCount = voteCount
        self.profileImageUrl = profileImageUrl
    }
}
