//
//  ThisWeekParticipantsResponse.swift
//  Domain
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ThisWeekParticipantsResponse: Decodable {
    public let data: [TournamentParticipantData]
    
    public init(data: [TournamentParticipantData]) {
        self.data = data
    }
}

public struct TournamentParticipantData: Decodable {
    public let thisWeekTournamentNo: Int
    public let userId: String
    public let profileImageUrl: String
    public let userName: String
    public let userSchool: String
    public let userBirth: String

    public init(
        thisWeekTournamentNo: Int,
        userId: String,
        profileImageUrl: String,
        userName: String,
        userSchool: String, 
        userBirth: String
    ) {
        self.thisWeekTournamentNo = thisWeekTournamentNo
        self.userId = userId
        self.profileImageUrl = profileImageUrl
        self.userName = userName
        self.userSchool = userSchool
        self.userBirth = userBirth
    }
}
