//
//  TournamentSearchResponse.swift
//  Domain
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct TournamentSearchResponse: Decodable {
    public let data: [TournamentSearchData]
    
    public init(data: [TournamentSearchData]) {
        self.data = data
    }
}

public struct TournamentSearchData: Decodable {
    public let category: String
    public let thisWeekTournamentNo: Int
    public var winner: [TournamentWinnerData]

    public init(
        category: String,
        thisWeekTournamentNo: Int,
        winner: [TournamentWinnerData]
    ) {
        self.category = category
        self.thisWeekTournamentNo = thisWeekTournamentNo
        self.winner = winner
    }
}

public struct TournamentWinnerData: Decodable {
    public let tournamentNo: Int
    public let round: Int
    public let profileImageUrl: String
    
    public init(
        tournamentNo: Int,
        round: Int,
        profileImageUrl: String
    ) {
        self.tournamentNo = tournamentNo
        self.round = round
        self.profileImageUrl = profileImageUrl
    }
}
